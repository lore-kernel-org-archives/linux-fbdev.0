Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAA62F9DBB;
	Mon, 26 Jan 2026 08:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769415480; cv=none; b=BHJ7wgNWks9GsEJTus9pNSs5A6xb4UiCQFd7vBZC812wanJR2VcTGP5d80ZZrMH+SpqdkFNA45XdkL5xKHu0l6FkLYua4b5CZs9xc0qYNVO+VTReYLHaXayQHyN4gJnTh/yOabFfLbeZhGsRjqdOd+2Nxv/6ZEJOnYFTqr1izlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769415480; c=relaxed/simple;
	bh=THLsKxDqzFVMxcykHFDOSQe3pZNn/rUzVn8Q6NDDVX0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MTJPCebs/dtwFiyo2r9EmCVuh2p0eUmgqvwvtQVUu2G7r7MoGzJb1vr4E4q5e3h6AHG/C72oK5sqq27II2996XSbnTeymPrw95K9yhFK/6fyBzWJKS4eovetTHaI7BkX+9p+FrF3yIrUhOZ+r62PRNZr8Aa6GWKOIOiqlc8mF2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8101bf5afa8f11f0b0f03b4cfa9209d1-20260126
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:4c867925-cbf2-4a73-8ad2-5840bbaa4f08,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:b4d84fc8c8820325b51a1020498ae6b6,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|898,TC:nil,Content:0|15|50
	,EDM:-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
	0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8101bf5afa8f11f0b0f03b4cfa9209d1-20260126
X-User: pengfuyuan@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <pengfuyuan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 546111531; Mon, 26 Jan 2026 16:17:50 +0800
From: pengfuyuan <pengfuyuan@kylinos.cn>
To: Danilo Krummrich <dakr@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Miguel Ojeda <ojeda@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Helge Deller <deller@gmx.de>,
	Hans de Goede <hansg@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Lee Jones <lee@kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Zsolt Kajtar <soci@c64.rulez.org>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	pengfuyuan <pengfuyuan@kylinos.cn>
Subject: [PATCH v1 v1 1/4] rust: io: mem: add ioremap_wc support
Date: Mon, 26 Jan 2026 16:17:41 +0800
Message-Id: <20260126081744.781392-2-pengfuyuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260126081744.781392-1-pengfuyuan@kylinos.cn>
References: <20260126081744.781392-1-pengfuyuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add write-combining memory mapping support to the Rust iomem abstraction.
This extends the existing IoMem and IoRequest abstractions to support
write-combining cache policy, which is essential for framebuffer memory
and other memory regions that benefit from write-combining semantics.

The implementation follows the same pattern as the existing ioremap and
ioremap_np support:
- Add rust_helper_ioremap_wc() in rust/helpers/io.c to wrap the C API
- Add IoMem::ioremap_wc() to perform the actual mapping with write-combining
- Add IoMem::new_wc() to create IoMem instances with write-combining policy
- Add IoRequest::iomap_wc_sized() and IoRequest::iomap_wc() methods
  for compile-time and runtime-sized mappings respectively

This enables Rust drivers, such as framebuffer drivers, to properly map
memory regions with write-combining semantics.

The API design is consistent with the existing iomap() methods, providing
both sized and unsized variants to match the pattern established by the
generic iomem abstraction.

Signed-off-by: pengfuyuan <pengfuyuan@kylinos.cn>
---
 rust/helpers/io.c     |  5 +++
 rust/kernel/io/mem.rs | 71 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/rust/helpers/io.c b/rust/helpers/io.c
index c475913c69e6..6c9edf7f2233 100644
--- a/rust/helpers/io.c
+++ b/rust/helpers/io.c
@@ -13,6 +13,11 @@ void __iomem *rust_helper_ioremap_np(phys_addr_t offset, size_t size)
 	return ioremap_np(offset, size);
 }
 
+void __iomem *rust_helper_ioremap_wc(phys_addr_t offset, size_t size)
+{
+	return ioremap_wc(offset, size);
+}
+
 void rust_helper_iounmap(void __iomem *addr)
 {
 	iounmap(addr);
diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
index b03b82cd531b..94403d899bbd 100644
--- a/rust/kernel/io/mem.rs
+++ b/rust/kernel/io/mem.rs
@@ -149,6 +149,41 @@ pub fn iomap(self) -> impl PinInit<Devres<IoMem<0>>, Error> + 'a {
     pub fn iomap_exclusive(self) -> impl PinInit<Devres<ExclusiveIoMem<0>>, Error> + 'a {
         Self::iomap_exclusive_sized::<0>(self)
     }
+
+    /// Maps an [`IoRequest`] with write-combining cache policy where the size
+    /// is known at compile time.
+    ///
+    /// This uses the [`ioremap_wc()`] C API, which provides write-combining
+    /// semantics. This is useful for framebuffer memory and other memory
+    /// regions that benefit from write-combining, where multiple writes can
+    /// be combined and reordered for better performance.
+    ///
+    /// Unlike [`Self::iomap`], this method explicitly uses write-combining
+    /// mapping, which is typically needed for video framebuffers.
+    ///
+    /// [`ioremap_wc()`]: https://docs.kernel.org/driver-api/device-io.html#getting-access-to-the-device
+    pub fn iomap_wc_sized<const SIZE: usize>(
+        self,
+    ) -> impl PinInit<Devres<IoMem<SIZE>>, Error> + 'a {
+        IoMem::new_wc(self)
+    }
+
+    /// Maps an [`IoRequest`] with write-combining cache policy where the size
+    /// is not known at compile time.
+    ///
+    /// This uses the [`ioremap_wc()`] C API, which provides write-combining
+    /// semantics. This is useful for framebuffer memory and other memory
+    /// regions that benefit from write-combining.
+    ///
+    /// Unlike [`Self::iomap_wc_sized`], here the size of the memory region
+    /// is not known at compile time, so only the `try_read*` and `try_write*`
+    /// family of functions should be used, leading to runtime checks on every
+    /// access.
+    ///
+    /// [`ioremap_wc()`]: https://docs.kernel.org/driver-api/device-io.html#getting-access-to-the-device
+    pub fn iomap_wc(self) -> impl PinInit<Devres<IoMem<0>>, Error> + 'a {
+        Self::iomap_wc_sized::<0>(self)
+    }
 }
 
 /// An exclusive memory-mapped IO region.
@@ -261,6 +296,33 @@ fn ioremap(resource: &Resource) -> Result<Self> {
         Ok(io)
     }
 
+    fn ioremap_wc(resource: &Resource) -> Result<Self> {
+        // Note: Some ioremap() implementations use types that depend on the CPU
+        // word width rather than the bus address width.
+        //
+        // TODO: Properly address this in the C code to avoid this `try_into`.
+        let size = resource.size().try_into()?;
+        if size == 0 {
+            return Err(EINVAL);
+        }
+
+        let res_start = resource.start();
+
+        // SAFETY:
+        // - `res_start` and `size` are read from a presumably valid `struct resource`.
+        // - `size` is known not to be zero at this point.
+        let addr = unsafe { bindings::ioremap_wc(res_start, size) };
+
+        if addr.is_null() {
+            return Err(ENOMEM);
+        }
+
+        let io = IoRaw::new(addr as usize, size)?;
+        let io = IoMem { io };
+
+        Ok(io)
+    }
+
     /// Creates a new `IoMem` instance from a previously acquired [`IoRequest`].
     pub fn new<'a>(io_request: IoRequest<'a>) -> impl PinInit<Devres<Self>, Error> + 'a {
         let dev = io_request.device;
@@ -268,6 +330,15 @@ pub fn new<'a>(io_request: IoRequest<'a>) -> impl PinInit<Devres<Self>, Error> +
 
         Devres::new(dev, Self::ioremap(res))
     }
+
+    /// Creates a new `IoMem` instance with write-combining cache policy from
+    /// a previously acquired [`IoRequest`].
+    pub fn new_wc<'a>(io_request: IoRequest<'a>) -> impl PinInit<Devres<Self>, Error> + 'a {
+        let dev = io_request.device;
+        let res = io_request.resource;
+
+        Devres::new(dev, Self::ioremap_wc(res))
+    }
 }
 
 impl<const SIZE: usize> Drop for IoMem<SIZE> {
-- 
2.25.1

