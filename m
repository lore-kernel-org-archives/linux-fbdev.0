From: Andy Lutomirski <luto@amacapital.net>
Date: Tue, 25 Jun 2013 01:05:11 +0000
Subject: Re: [RFC 3/6] drm: add SimpleDRM driver
Message-Id: <51C8ECC7.4030404@mit.edu>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1372112849-670-1-git-send-email-dh.herrmann@gmail.com> <1372112849-670-4-git-send-email-dh.herrmann@gmail.com>
In-Reply-To: <1372112849-670-4-git-send-email-dh.herrmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Herrmann <dh.herrmann@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Dave Airlie <airlied@gmail.com>, linux-fbdev@vger.kernel.org, Stephen Warren <swarren@nvidia.com>, Olof Johansson <olof@lixom.net>

On 06/24/2013 03:27 PM, David Herrmann wrote:
> +	sdrm->fb_map = ioremap(sdrm->fb_base, sdrm->fb_size);

This should probably be ioremap_wc.  Otherwise it will be *really* slow
if used in legacy mode and it may cause conflicts with the
pgprot_writecombine mode for mmap.

(Watching boot messages go by on fbcon on efifb was like using an old
2400 baud modem before I made the corresponding change to efifb.)

--Andy
