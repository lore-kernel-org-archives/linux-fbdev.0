Received: from mail-106118.protonmail.ch (mail-106118.protonmail.ch [79.135.106.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9DF421EED;
	Thu, 28 May 2026 18:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779993419; cv=none; b=S0V5sFF23Nowq4AbpHDO+xGkvhei+W2WvncooKzVcm/QVL8AjGg0f2HheBGRu1SWQj9htlJQrIlQjJKsnV0P3VyccJW6obA0CSsxrI+FErNR4L9FaTMzD0qUvzd/WLQVG7CEgmDUmaQVgyeHzJlPCV2eHH2QqW3FFkdsMQNkkPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779993419; c=relaxed/simple;
	bh=FtCHS5ApOptDXAaYgyUzMGHQY3mB60VC48bf5WynBXE=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Nw2qPw6Fvh3wcgDWOWSB5lvVv+8097hT/rLsJpG5wIp0aH9+G896KAxd3uZSgBSsvv7cED8G2lz088dejQLzet5GnglDLLwlU957KQPyn30xqM02JmxSYFxXCTbp3vaG0E4M1Kczaq92p+DYpvcqZeZmLv6Xd/bpm071OHS6ZC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=L4rgiWfN; arc=none smtp.client-ip=79.135.106.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="L4rgiWfN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=j4xjwnoogrghpd4lbo5tq72bce.protonmail; t=1779993410; x=1780252610;
	bh=FtCHS5ApOptDXAaYgyUzMGHQY3mB60VC48bf5WynBXE=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=L4rgiWfNjH7WO5iGN53ZA5RoCDaPi11XGvsNqOgYRXR1redOCsuf5Rl93hYqDyMt9
	 KfwC9pR9xjOE6kerDWTkoSMbryiV2iRha7DDmOWu2pmCSoibxQaw5d+17dIaBlYJp+
	 DaYnitocYDc8gzgzAGeefuXz1YxorSbIWBmx0CQunmsC3i0C0La6K7iTzkRLKDYp9/
	 Y+wrMq5rYVSBAg6u+E4r2EbhmZv4VpBMQ/b//oE8qysdyqlVYEcNJguwDBx1ZLQ417
	 Scg8ewzlEMQCNCxwOC/juOhGeVNaQ6qyM166fM+9dE1w5nUoESscfo9g2fw0gi0BMW
	 xMvQnO/ECqshQ==
Date: Thu, 28 May 2026 18:36:45 +0000
To: "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>, "teddy.wang@siliconmotion.com" <teddy.wang@siliconmotion.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
From: Gabry <Gabry.256@proton.me>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] staging: sm750fb: rename Bpp parameter to bpp
Message-ID: <hpslpD7esY-xE37Tvrz0V8gD8YoZwdu6IlQ8LjUz5fY5mevEeDxM-dLC64t43G4mpVfHB_xCDUESoNFZ7ua9k7B_k2NrY2u-P6NYIJSuGt4=@proton.me>
Feedback-ID: 103051392:user:proton
X-Pm-Message-ID: b09bde1e8660b13c9c0cd7e31c3a17c4fa32c7a3
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The Linux kernel coding style prefers snake_case over CamelCase foridentifi=
er names.

Rename the 'Bpp' parameter (bytes per pixel) of sm750_hw_fillrect()
and sm750_hw_copyarea() to 'bpp' to comply with this standard. Update
the function prototypes in sm750_accel.h and the corresponding
kernel-doc descriptions accordingly.

This is a pure rename with no functional change, and addresses a
checkpatch.pl warning:

=C2=A0 CHECK: Avoid CamelCase: <Bpp>

Signed-off-by: Gabriele Rizzo <gabry.256@proton.me>
---
=C2=A0drivers/staging/sm750fb/sm750_accel.c | 22 +++++++++++-----------
=C2=A0drivers/staging/sm750fb/sm750_accel.h | =C2=A06 +++---
=C2=A02 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750f=
b/sm750_accel.c
index 0f94d859e91c..4beabe1053f9 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -85,7 +85,7 @@ void sm750_hw_set2dformat(struct lynx_accel *accel, int f=
mt)
=C2=A0}

=C2=A0int sm750_hw_fillrect(struct lynx_accel *accel,
- =C2=A0 =C2=A0 u32 base, u32 pitch, u32 Bpp,
+ =C2=A0 =C2=A0 u32 base, u32 pitch, u32 bpp,
=C2=A0 =C2=A0 =C2=A0 u32 x, u32 y, u32 width, u32 height,
=C2=A0 =C2=A0 =C2=A0 u32 color, u32 rop)
=C2=A0{
@@ -102,14 +102,14 @@ int sm750_hw_fillrect(struct lynx_accel *accel,

=C2=A0 write_dpr(accel, DE_WINDOW_DESTINATION_BASE, base); /* dpr40 */
=C2=A0 write_dpr(accel, DE_PITCH,
- ((pitch / Bpp << DE_PITCH_DESTINATION_SHIFT) &
+ ((pitch / bpp << DE_PITCH_DESTINATION_SHIFT) &
=C2=A0 =C2=A0DE_PITCH_DESTINATION_MASK) |
- (pitch / Bpp & DE_PITCH_SOURCE_MASK)); /* dpr10 */
+ (pitch / bpp & DE_PITCH_SOURCE_MASK)); /* dpr10 */

=C2=A0 write_dpr(accel, DE_WINDOW_WIDTH,
- ((pitch / Bpp << DE_WINDOW_WIDTH_DST_SHIFT) &
+ ((pitch / bpp << DE_WINDOW_WIDTH_DST_SHIFT) &
=C2=A0 =C2=A0DE_WINDOW_WIDTH_DST_MASK) |
- =C2=A0(pitch / Bpp & DE_WINDOW_WIDTH_SRC_MASK)); /* dpr44 */
+ =C2=A0(pitch / bpp & DE_WINDOW_WIDTH_SRC_MASK)); /* dpr44 */

=C2=A0 write_dpr(accel, DE_FOREGROUND, color); /* DPR14 */

@@ -138,7 +138,7 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
=C2=A0 * @sy: Starting y coordinate of source surface
=C2=A0 * @dest_base: Address of destination: offset in frame buffer
=C2=A0 * @dest_pitch: Pitch value of destination surface in BYTE
- * @Bpp: Color depth of destination surface
+ * @bpp: Color depth of destination surface
=C2=A0 * @dx: Starting x coordinate of destination surface
=C2=A0 * @dy: Starting y coordinate of destination surface
=C2=A0 * @width: width of rectangle in pixel value
@@ -149,7 +149,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
=C2=A0 =C2=A0 =C2=A0 unsigned int source_base, unsigned int source_pitch,
=C2=A0 =C2=A0 =C2=A0 unsigned int sx, unsigned int sy,
=C2=A0 =C2=A0 =C2=A0 unsigned int dest_base, unsigned int dest_pitch,
- =C2=A0 =C2=A0 unsigned int Bpp, unsigned int dx, unsigned int dy,
+ =C2=A0 =C2=A0 unsigned int bpp, unsigned int dx, unsigned int dy,
=C2=A0 =C2=A0 =C2=A0 unsigned int width, unsigned int height,
=C2=A0 =C2=A0 =C2=A0 unsigned int rop2)
=C2=A0{
@@ -249,9 +249,9 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
=C2=A0 * pixel values. Need Byte to pixel conversion.
=C2=A0 */
=C2=A0 write_dpr(accel, DE_PITCH,
- ((dest_pitch / Bpp << DE_PITCH_DESTINATION_SHIFT) &
+ ((dest_pitch / bpp << DE_PITCH_DESTINATION_SHIFT) &
=C2=A0 =C2=A0DE_PITCH_DESTINATION_MASK) |
- (source_pitch / Bpp & DE_PITCH_SOURCE_MASK)); /* dpr10 */
+ (source_pitch / bpp & DE_PITCH_SOURCE_MASK)); /* dpr10 */

=C2=A0 /*
=C2=A0 * Screen Window width in Pixels.
@@ -259,9 +259,9 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
=C2=A0 * for a given point.
=C2=A0 */
=C2=A0 write_dpr(accel, DE_WINDOW_WIDTH,
- ((dest_pitch / Bpp << DE_WINDOW_WIDTH_DST_SHIFT) &
+ ((dest_pitch / bpp << DE_WINDOW_WIDTH_DST_SHIFT) &
=C2=A0 =C2=A0DE_WINDOW_WIDTH_DST_MASK) |
- (source_pitch / Bpp & DE_WINDOW_WIDTH_SRC_MASK)); /* dpr3c */
+ (source_pitch / bpp & DE_WINDOW_WIDTH_SRC_MASK)); /* dpr3c */

=C2=A0 if (accel->de_wait() !=3D 0)
=C2=A0 return -1;
diff --git a/drivers/staging/sm750fb/sm750_accel.h b/drivers/staging/sm750f=
b/sm750_accel.h
index 2c79cb730a0a..d15a40cacb84 100644
--- a/drivers/staging/sm750fb/sm750_accel.h
+++ b/drivers/staging/sm750fb/sm750_accel.h
@@ -190,7 +190,7 @@ void sm750_hw_set2dformat(struct lynx_accel *accel, int=
 fmt);
=C2=A0void sm750_hw_de_init(struct lynx_accel *accel);

=C2=A0int sm750_hw_fillrect(struct lynx_accel *accel,
- =C2=A0 =C2=A0 u32 base, u32 pitch, u32 Bpp,
+ =C2=A0 =C2=A0 u32 base, u32 pitch, u32 bpp,
=C2=A0 =C2=A0 =C2=A0 u32 x, u32 y, u32 width, u32 height,
=C2=A0 =C2=A0 =C2=A0 u32 color, u32 rop);

@@ -202,7 +202,7 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
=C2=A0 * @sy: Starting y coordinate of source surface
=C2=A0 * @dBase: Address of destination: offset in frame buffer
=C2=A0 * @dPitch: Pitch value of destination surface in BYTE
- * @Bpp: Color depth of destination surface
+ * @bpp: Color depth of destination surface
=C2=A0 * @dx: Starting x coordinate of destination surface
=C2=A0 * @dy: Starting y coordinate of destination surface
=C2=A0 * @width: width of rectangle in pixel value
@@ -213,7 +213,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
=C2=A0 =C2=A0 =C2=A0 unsigned int sBase, unsigned int sPitch,
=C2=A0 =C2=A0 =C2=A0 unsigned int sx, unsigned int sy,
=C2=A0 =C2=A0 =C2=A0 unsigned int dBase, unsigned int dPitch,
- =C2=A0 =C2=A0 unsigned int Bpp, unsigned int dx, unsigned int dy,
+ =C2=A0 =C2=A0 unsigned int bpp, unsigned int dx, unsigned int dy,
=C2=A0 =C2=A0 =C2=A0 unsigned int width, unsigned int height,
=C2=A0 =C2=A0 =C2=A0 unsigned int rop2);

--
2.54.0
