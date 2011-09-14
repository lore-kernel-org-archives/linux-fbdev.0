From: Timur Tabi <timur@freescale.com>
Date: Wed, 14 Sep 2011 21:39:15 +0000
Subject: Re: [REPOST][PATCH 1/2] fbdev: fix indentation in modedb.c
Message-Id: <4E711F03.4050908@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1315929909-26311-1-git-send-email-timur@freescale.com>
In-Reply-To: <1315929909-26311-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Florian Tobias Schandinat wrote:
> Applied this patch, although I do not like this sort of patches very much. Well,
> I guess it's an improvement, are you doing some real work on this code?

Yes, but I needed to make it sane first.  The big issue is that it initializes
the hardware when the driver loads, not when it's open by the framebuffer layer.

I understand the complaint against multiple changes combined into one patch, but
all I was doing was just going through the code line-by-line and looking for
minor problems.

I do appreciate your applying the patch as-is.  I was not looking forward to
breaking it up into multiple pieces.

-- 
Timur Tabi
Linux kernel developer at Freescale

