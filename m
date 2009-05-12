From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] video: add sh_mobile_lcdcfb memory resource
Date: Tue, 12 May 2009 19:50:14 +0900
Message-ID: <20090512105013.GA20500@linux-sh.org>
References: <20090512095745.25477.87326.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090512095745.25477.87326.sendpatchset@rx1.opensource.se>
Sender: linux-sh-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On Tue, May 12, 2009 at 06:57:45PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> This patch adds memory resource support to the LCDC driver.
> With this applied the physical memory range used for framebuffer
> data will show up in /proc/iomem together with other SuperH
> Mobile devices.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

Drivers have no place doing this on their own, besides, insert_resource()
is not available to modules. The platform device code already takes care
of this, so perhaps I am missing what the point of this change is?
