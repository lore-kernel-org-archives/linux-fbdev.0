From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 17 Mar 2015 22:27:31 +0000
Subject: Re: [PATCH] video: fbdev: sh_mobile_lcdcfb: Fix ROP3 sysfs attribute parsing
Message-Id: <1932486.kfGUBgjCEZ@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426347519-2541-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1426347519-2541-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Tomi,

Could you please pick this patch up for v4.1 ? I can send a pull request if it 
makes your life easier.

On Sunday 15 March 2015 10:32:11 Geert Uytterhoeven wrote:
> On Sat, Mar 14, 2015 at 4:38 PM, Laurent Pinchart wrote:
> > The ROP3 attribute is expressed as an integer in the 0-255 range. Remove
> > the wrong conversion to boolean when parsing it.
> > 
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> 
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

-- 
Regards,

Laurent Pinchart

