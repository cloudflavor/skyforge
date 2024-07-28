use proc_macro::TokenStream;
use quote::quote;
use syn::{parse_macro_input, ItemImpl};

#[proc_macro_attribute]
pub fn skyforge_plugin(_: TokenStream, input: TokenStream) -> TokenStream {
    let impl_trait = parse_macro_input!(input as ItemImpl);
    let name = impl_trait.self_ty;
    if let Some((_, path, _)) = &impl_trait.trait_ {
        let trait_name = path.get_ident().unwrap();
        if trait_name != "SkyforgePlugin" {
            panic!("Expected trait name to be `SkyforgePlugin`");
        }
    }

    let trait_items = &impl_trait.items;

    let expanded = quote! {

        wit_bindgen::generate!({path: "wit", world: "skyforge-api"});

        use exports::cloudflavor::skyforge::plugin_api::{Guest, Config,Error};

        impl Guest for #name {
            fn deserialize_config(config: String) -> Result<Config, Error> {
                let config = Self::deserialize_config_impl(config).unwrap();
                Ok(config)
            }
        }

        export!(#name);

        impl #name {
            #(#trait_items)*
        }
    };

    TokenStream::from(expanded)
}
