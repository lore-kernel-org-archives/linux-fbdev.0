From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [Linux-fbdev-devel] [2.6 patch] drivers/video/: misc cleanups
Date: Mon, 22 Nov 2004 10:54:44 +0800
Message-ID: <200411221054.48496.adaplas@hotpop.com>
References: <20041121153702.GB2829@stusta.de>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261908AbUKVC6n@vger.kernel.org>
In-Reply-To: <20041121153702.GB2829@stusta.de>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On Sunday 21 November 2004 23:37, Adrian Bunk wrote:
> The patch below does the following cleanups under drivers/video/ :
> - make some needlessly global code static
> - the following was needlessly EXPORT_SYMBOL'ed:
>   - fbcon.c: fb_con
>   - mdacon.c: fb_blank
>   - fbmon.c: get_EDID_from_firmware (completely unused)
>
> Please review this patch.

Looks ok.

Tony
