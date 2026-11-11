Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794396644;
	b=nS1xjwklfPFxaWlTPFVBgax1LP/zqIwTbcJK0Aosb+RWFvd0IxRsmeQKlfX+kY0E1XQH
	 OTfh4UZHylKRcHBF9qrvgv+WjOscfflIxnuegjuZuQvuTj4Q2TdesuWPca3eM/KddosT5
	 hS+m7jkq+Zljk6hAIVejs1uwPDJVvESi+yJH3T17GrgGtCJV0oHX+murkcldNjBIDXwfS
	 LMpL5UbSzPCqyMV6GVKGNgjc+tLIK0QO3q1dLsXkNzDq5i+zzv3dxcOj87iJ37RnIHjI+
	 5DpOajn0gIa0s+XSHM0Wt0Cy9rMhrsa6Yuv1k6AWRNKFKUSDFBs3/xVYIoxT2SXT3aA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794396644;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=UgfkhFQDE5XUrpu/BniOwomSfmu/mN0hFz5scbETrso=;
	b=IQd1BXgydBaFO/75RZg2NoYhU2VfPXDLtXiDYcx7ARUHPD+Us1QViiChXYKYXAi2v/Ct
	 w2Io471VKehUWmjlK4OU1yDV8YnywC0LcDk1LrOE3jewaMzS3r4bZR4lYczBXmc4Q/zwL
	 9RYXhF3q+HOnwktEQNKYbXnqiODtSURNI6CzcS4Rx1Q50zatWSm8w4WRH5ILYgUj9DrBq
	 0is3wiiCUIlltopPRnlS9EWXtPByUkPnzuTLtRBJBAZWEMVaf01BLPR0/jtCmvQrSwCTB
	 UXvqBCS/ts+TZ4y25EA5E6DhU6cm/gZmdal4PZsmzZiTlHIzd1232BjNCl25lxTxqow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NS36bZU2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AFA606A881
	for <linux-fbdev@vger.kernel.org>; Wed, 11 Nov 2026 11:30:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5AFA606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NS36bZU2
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-49134c8509fso2525604f8f.1
        for <linux-fbdev@vger.kernel.org>; Wed, 11 Nov 2026 03:30:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794396642; cv=none;
        d=google.com; s=arc-20260327;
        b=KPztYlyhQ8RpqAZL5d+ZenD5CkAWTno+TjkqTn5mlyPNhuUZJQxL/0kdc81vzI/dYD
         yTw+9y9mRFpIfFu1fg8ygU/7eB4qgcRpJMXYk43wq4EoCi+XdvjG6cuRxIcxhQMc8Z67
         5+8Ygd3SPm9tGApQjc0ubN511FPOh51GJZtMl0gtSlYBwBNZEvQyGJP8FXIwnlrwSRIU
         eN1bD1IPcXJDKKSQLOxZlQKQGhIYBq4SBGaL6USPo8k8oCA321MlCgFyUzy8p+IfwOYO
         Uiuwv18IFxQGWsji6c7JQb1xdALy9IAdpPjg2CkjSl9JNRblSF9XZePBJmLQeJXE3Xm3
         RoEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UgfkhFQDE5XUrpu/BniOwomSfmu/mN0hFz5scbETrso=;
        fh=xe8gcvDRJlFULeM9rxCL6P7cA1ExCPx/7ej0rqXseog=;
        b=Due0ihOWXR0sBzfweUuN87JO5hK+ktqsh9s6TK68FCscS3XEiFactjU1pZ07AaAt0Z
         Tub8Tf9aHHJV7wM4tJDaZsM6T0hu6cMRbyXwm0ElSH9mzi3isysJJ1Q3OhQwj0Pf0gXH
         op9cw67Gav/EQr6i7727WWMgsFw90HlZU34O3o0FY811Idtdqnn10BcvQ3wYKorjN435
         ypof76I/k6DJ2jDV1UazLli41qCVRrgxjf/dqvoktWkgUxNTHpQbtsWiXW2UbamKf0qT
         2153Lvt6H26Vr5Df7cEXZUlVk0x5Y8WXJG9KH6jKa+7cOQQJ+qXzJt1ld3hLGQ7Nn4/u
         Xftw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794396642; x=1795001442; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UgfkhFQDE5XUrpu/BniOwomSfmu/mN0hFz5scbETrso=;
        b=NS36bZU2Lp1nN7SgynVLZLw4RRYvh4TfXs2ptYnXHx49pXVEMx3uN77gfrFOQhYpcB
         5td1a3OO3EVpbd7NH5diznNdsyfLhj2pKanFjQwiIQn8bkXHD1EeLwpczd5dyqwe6vQr
         b5dEPkX0QnkeAesn6bi2CyOnDQ/IuCKZ/X1Na59/S+5rLThdGSTshxLXGW4iDIMQbCsU
         RSfWXBJhHFQtmGK8s6lXVMPhXtLakPBe5Y52OLtdksA8f/hEu/Vik1a8HnfGL7b50vji
         xzSPZoyGJQaXLaUWK8aIwDVBTvm/L7huiIZ5ayuxrevfLOyzBV/O2jHCTsWh1nzM/9Vh
         qXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794396642; x=1795001442;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UgfkhFQDE5XUrpu/BniOwomSfmu/mN0hFz5scbETrso=;
        b=OXgxbqkMLUn+M5t/hwDK61UY4m+wguKV2paYC9aTAdIPQaVu5Qo2Y+okpSk818pKEr
         /lV9Tgv9kmYRv0P4GJXpBBQugWcQbzTdeaOnRHr/zgNnhkOQ8YWPYB0w6/2bOJKtexXU
         kTkEGhfjkJ4ZXvhOoMDw+fcuKzOnCrIQwsUACuaNNL8QCG/872w9+AYKXW+aS7HnD2gF
         R9BYYbHzSEBrcQiM6Zt26Pd0vQM+xpnLawX0TtGU62UN0GLSCZpTlrPufE7bQXGAKx9c
         QDfRp1b4rDC72MRVt7GDtO/j+9hw8/pornolfU4VJtTjz2DWMMHph5SYY9gGJnf1JHRU
         djzQ==
X-Forwarded-Encrypted: i=1; AL+hErFwR8niwnLOqnUpaRV9jXXaGcwLFkP70ih2SAmSp9L8CTGParba+WMmeML8GBA4IidrNg5PXgCNh4fq+g==@vger.kernel.org
X-Gm-Message-State: APuU4Z9cF5pPWLPqddFYMC+zos0W9VhdAXxWCo9cS2pC8zRBE0NknP1t
	8gy0xcKijuj3VkYCW2YtLX1BZTAKOyUTBeM44kfHgKb18ZjaRAy05ldKxDvRbdnfRrGh7ML6OK6
	ZIMcyQBnI+vX21OZGFPCPTbLqUcBhYZc=
X-Gm-Gg: AYBFou3rceT91HOHkfKPJ5Tu+xAB5m4UTpVR5pPtIabzqattDWHfYYJWsGAmqLTFd7V
	+VpWQH7xdHFID7w51KeZVCgYm/SgMiBAg08k54I6tTjT1nyOySUi7s/h/jtDVKTHvWv7W7ihEpx
	/dw6CrMDmYbTykFFt0nmHzbWhNHBSwhyJboMBJOi7e6QyQrYwDRcP5HUSoS+wb5vJVsPeMGYUOz
	ijef8PMBcnHZa4sS+ZH5YLETOYtVnJWEWGyqAQ+ElG26OYtkmg60P0NwIK1PCrTCXv7FLueCXOa
	tNYTMLYFc5OKQP0QKawBArkXmBHsWeu+i6uYbHJThMmH/s3XuDuBrw1vDmdxSavjbliAlYjEVhi
	Zw2G5zXiOVibjDC6BMHWYJQsszoUSaEEI8LzumVpcqg1QbIznxFnIFLnd2Qw=
X-Received: by 2002:a05:6000:4a09:b0:48f:e879:5890 with SMTP id
 ffacd0b85a97d-499c7368708mr3693601f8f.32.1794396641750; Wed, 11 Nov 2026
 03:30:41 -0800 (PST)
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260923060924.45742-1-syedtayyabfarooq08@gmail.com>
In-Reply-To: <20260923060924.45742-1-syedtayyabfarooq08@gmail.com>
From: Syed Tayyab Farooq <syedtayyabfarooq08@gmail.com>
Date: Wed, 11 Nov 2026 16:30:29 +0500
X-Gm-Features: AclHuK8l6XMFWNrCKlt8GZ3LUscrj4Ss66FjgXR0gQdCuuxpBLlr3WsNlgeFcLo
Message-ID: <CAKD4hN5rOFCczzdBzgyD15EWvcgK=KRgyXihqfE-hd1XydnLKQ@mail.gmail.com>
Subject: Re: [PATCH] fbdev: fbcon: Fix KASAN slab-out-of-bounds read in
 rotated font buffer
To: Helge Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, 
	Andrew Morton <akpm@osdl.org>, 
	"open list:FRAMEBUFFER CONSOLE" <dri-devel@lists.freedesktop.org>, 
	"open list:FRAMEBUFFER CONSOLE" <linux-fbdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Cc: syzbot+bf4020519fbd94b2355d@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I wanted to follow up on this patch, if anyone has had a chance to review i=
t.

Thanks,
Tayyab

On Wed, Sep 23, 2026 at 11:10=E2=80=AFAM Syed Tayyab Farooq
<syedtayyabfarooq08@gmail.com> wrote:
>
> The root cause of this KASAN slab-out-of-bounds read is that fbcon fails =
to
> reallocate the rotated font buffer (par->rotated.buf) when the font
> character count changes but the font dimensions (width and height) remain
> the same.
>
> When a user changes the font via ioctl(KDFONTOP), fbcon_do_set_font() is
> called. If the user first sets a 256-character font, enables rotation, an=
d
> then sets a 512-character font with the exact same width and height, resi=
ze
> evaluates to false. The function then directly calls update_screen(vc).
> Notice that fbcon_do_set_font() never calls par->bitops->rotate_font() to
> update the rotated font buffer for the new font. As a result,
> par->rotated.buf remains sized for the old 256-character font.
>
> When update_screen(vc) is called, it eventually reaches cw_putcs_aligned(=
),
> which attempts to read the glyphs from the rotated buffer. Since
> vc->vc_font.charcount is now 512, vc->vc_hi_font_mask is set, making
> charmask equal to 0x1ff (511). If the text buffer contains a character wi=
th
> an index >=3D 256, src will point out of bounds of the old par->rotated.b=
uf
> (which only holds 256 glyphs). The subsequent read in
> __fb_pad_aligned_buffer() triggers the KASAN slab-out-of-bounds crash.
>
> To fix this, fbcon_do_set_font() must call par->bitops->rotate_font() to
> update the rotated font buffer before calling vc_resize() or
> update_screen(). If vc_resize() fails and the old font is restored in the
> error path, rotate_font() must be called again to restore the rotated
> buffer.
>
> This pattern of updating the rotated font buffer was previously establish=
ed
> in fbcon_modechanged() by commit ef7656e85f1a ("fbdev: Fix out-of-bounds
> access when rotating console after font resize"). The fix applies this
> exact idiom to fbcon_do_set_font(). By placing it before vc_resize() and
> update_screen(), we ensure the buffer is correctly sized before any
> rendering occurs. Checking con_is_visible(vc) is also correct here, as
> hidden consoles will have their rotation state updated later via
> fbcon_switch() when they become visible.
>
> Furthermore, by calling rotate_font() again in the err_out path, we ensur=
e
> that if vc_resize() fails, the rotated buffer is restored to match the ol=
d
> vc->vc_font. Without this, restoring a 512-character font to a
> 256-character font on failure would leave the rotated buffer sized for 51=
2
> characters, which wastes memory; or worse, restoring a 256-character font
> to a 512-character font would leave the buffer too small, causing an
> out-of-bounds read later.
>
> Fixes: e4fc27618b75 ("[PATCH] fbcon: Console Rotation - Prepare fbcon for=
 console rotation")
> Assisted-by: Gemini:gemini-3.6-flash Gemini:gemini-3.1-pro-preview syzbot
> Reported-by: syzbot+bf4020519fbd94b2355d@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dbf4020519fbd94b2355d
> Link: https://syzkaller.appspot.com/ai_job?id=3D59f0d7d9-607c-4497-b2e2-0=
b16693f9502
> Signed-off-by: Syed Tayyab Farooq <syedtayyabfarooq08@gmail.com>
> ---
>  drivers/video/fbdev/core/fbcon.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/=
fbcon.c
> index 01715873ea49..158b2f91d68e 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -2432,6 +2432,13 @@ static int fbcon_do_set_font(struct vc_data *vc, i=
nt w, int h, int charcount,
>         else if (!vc->vc_hi_font_mask && charcount =3D=3D 512)
>                 set_vc_hi_font(vc, true);
>
> +       if (con_is_visible(vc)) {
> +               if (par->bitops->rotate_font && par->bitops->rotate_font(=
info, vc)) {
> +                       par->rotate =3D FB_ROTATE_UR;
> +                       set_blitting_type(vc, info);
> +               }
> +       }
> +
>         if (resize) {
>                 int cols, rows;
>
> @@ -2466,6 +2473,13 @@ static int fbcon_do_set_font(struct vc_data *vc, i=
nt w, int h, int charcount,
>         else if (!old_hi_font_mask && vc->vc_hi_font_mask)
>                 set_vc_hi_font(vc, false);
>
> +       if (con_is_visible(vc)) {
> +               if (par->bitops->rotate_font && par->bitops->rotate_font(=
info, vc)) {
> +                       par->rotate =3D FB_ROTATE_UR;
> +                       set_blitting_type(vc, info);
> +               }
> +       }
> +
>         font_data_put(data);
>
>         return ret;
> --
> 2.43.0
>
