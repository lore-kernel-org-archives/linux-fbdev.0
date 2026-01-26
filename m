Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B3824113D;
	Mon, 26 Jan 2026 08:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769415477; cv=none; b=GnE0B40EEjpwLJMF+CKAgev3+fAR1POF7lqYyBgQC7blbIU22lV31RPmQxGByuSl7jNuLNNl7DKNaKYxD3OPZKkTDnfMMKhlRJw6chljpx4hnXR7wEI5W+g0DjO4sp5+FDZCyc5Dc6uwM0USCGhLopcH/wz7oq3g28zFdSgmZoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769415477; c=relaxed/simple;
	bh=ZV+y3n2UPfl9QAWdzck61V9hDjuyMPdvbMtJe0/JfBE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JX26psO9uc58W/iM4Aj1EsGXjZYw15AdCZPHIvQoJlrliVFMS1z3jcNdH2AW0J3XurONmHWbxhYgJiaPpfGT+GVLKl1TxwB1+/Tm8HKNqEKubxEB1mtx08oO9AJWyN1N2aIOZ44zYj1AXL6dNR6ko4BHKy6jpGhuQ032f4TniPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 807a68f2fa8f11f0b0f03b4cfa9209d1-20260126
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:8a3c612f-7ffb-4c5a-951e-85a6fec6eb78,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:183c2674dc5f80bf5febbde31a2928b0,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|898,TC:nil,Content:0|15|50,EDM:-
	3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 807a68f2fa8f11f0b0f03b4cfa9209d1-20260126
X-User: pengfuyuan@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <pengfuyuan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 603079910; Mon, 26 Jan 2026 16:17:49 +0800
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
Subject: [PATCH v1 v1 0/4] [RUST] Framebuffer driver support
Date: Mon, 26 Jan 2026 16:17:40 +0800
Message-Id: <20260126081744.781392-1-pengfuyuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds Rust bindings and safe abstractions for the Linux
framebuffer subsystem, enabling framebuffer drivers to be implemented in Rust.

The series consists of 4 patches:

1. rust: io: mem: add ioremap_wc support
   Adds write-combining memory mapping support to the Rust iomem abstraction,
   which is essential for framebuffer memory regions that benefit from
   write-combining semantics.

2. rust: device: add platdata accessors
   Implements generic accessors for platform data, enabling drivers to access
   platform-provided configuration. This is needed for framebuffer drivers
   that use platform data for configuration.

3. rust: fb: add framebuffer driver support
   Adds the core framebuffer framework abstraction, including:
   - Device abstraction (`fb::Device`) with reference counting via `AlwaysRefCounted`
   - Driver and Operations traits (`fb::Driver`, `fb::Operations`)
   - Screen information wrappers (`fb::FixScreenInfo`, `fb::VarScreenInfo`)
   - I/O operation helpers (`fb_io_read`, `fb_io_write`, `fb_io_mmap`)
   - Blit operation helpers (`cfb_fillrect`, `cfb_copyarea`, `cfb_imageblit`)

4. rust: fb: add simplefb test driver
   Adds a test driver that validates the framebuffer framework by porting
   the C simplefb driver to Rust. This driver serves as both a validation
   tool and a reference implementation for future Rust framebuffer drivers.

The implementation follows the same patterns established in the DRM subsystem
and maintains full compatibility with the existing C framebuffer subsystem.
All C callbacks are properly bridged to Rust trait methods via the `Operations`
trait, memory safety is ensured through proper use of `Opaque<fb_info>`, `ARef`,
and `AlwaysRefCounted` for reference counting, type invariants are documented
and enforced through the type system, and resource cleanup is handled via RAII
with proper cleanup order.

Testing:
--------
This series has been tested on:
- ARM64 platforms with various display configurations
- AMD RX550 graphics card
- Moore Threads S30 graphics card
- Multiple other graphics cards

All tested configurations show normal display functionality with proper
framebuffer initialization, rendering operations (including I/O, color register
management, and blitting), memory mapping, and resource cleanup. The simplefb
test driver successfully demonstrates the usage of all framebuffer framework
APIs and validates the abstraction's correctness.

The simplefb test driver serves as both a validation tool and a reference
implementation for future Rust framebuffer drivers.


pengfuyuan (4):
  rust: io: mem: add ioremap_wc support
  rust: device: add platdata accessors
  rust: fb: add framebuffer driver support
  rust: fb: add simplefb test driver

 drivers/video/fbdev/Kconfig          |  21 +
 drivers/video/fbdev/Makefile         |   1 +
 drivers/video/fbdev/simplefb_rust.rs | 653 +++++++++++++++++++++++++++
 rust/bindings/bindings_helper.h      |   2 +
 rust/helpers/device.c                |   5 +
 rust/helpers/io.c                    |   5 +
 rust/kernel/device.rs                |  31 ++
 rust/kernel/fb/blit.rs               | 106 +++++
 rust/kernel/fb/device.rs             | 463 +++++++++++++++++++
 rust/kernel/fb/driver.rs             | 169 +++++++
 rust/kernel/fb/io.rs                 |  76 ++++
 rust/kernel/fb/mod.rs                |  23 +
 rust/kernel/fb/screeninfo.rs         | 318 +++++++++++++
 rust/kernel/io/mem.rs                |  71 +++
 rust/kernel/lib.rs                   |   2 +
 15 files changed, 1946 insertions(+)
 create mode 100644 drivers/video/fbdev/simplefb_rust.rs
 create mode 100644 rust/kernel/fb/blit.rs
 create mode 100644 rust/kernel/fb/device.rs
 create mode 100644 rust/kernel/fb/driver.rs
 create mode 100644 rust/kernel/fb/io.rs
 create mode 100644 rust/kernel/fb/mod.rs
 create mode 100644 rust/kernel/fb/screeninfo.rs

-- 
2.25.1

