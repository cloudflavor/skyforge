/// # Safety
///
/// This file is safe to use. It's a simple FFI interface to the Rust code.
#[no_mangle]
pub unsafe extern "C" fn do_request(data_ptr: *const u8, len: usize) -> *mut u8 {
    let data = unsafe { std::slice::from_raw_parts(data_ptr, len) };
    let mut buf = Vec::with_capacity(len);
    buf.append(&mut data.to_vec());
    let ptr = buf.as_mut_ptr();
    std::mem::forget(buf);
    ptr
}
