From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 06 Sep 2011 08:51:47 +0000
Subject: Re: [PATCH v2 0/8] sh_mobile_lcdc: Support format changes at runtime
Message-Id: <201109061051.47768.laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1314788459-31791-1-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1314788459-31791-1-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Florian,

On Monday 05 September 2011 19:19:08 Florian Tobias Schandinat wrote:
> On 08/31/2011 11:00 AM, Laurent Pinchart wrote:
> > Hi everybody,
> > 
> > Here's the second version of the .fb_set_par() support for the
> > sh_mobile_lcdc driver patch set. It allows userspace to change the frame
> > buffer format and size at runtime. The patches apply on top of Florian's
> > fbdev-next branch available at
> > git://github.com/schandinat/linux-2.6.git.
> > 
> > Compared to v1, this version includes an additional MERAM fix.
> > 
> > Frame buffer memory reallocation is currently not supported. You will
> > need to make sure platform data sets the maximum size and bpp to high
> > enough values for all formats and sizes you want to support at runtime.
> 
> As you've asked me in
> 	"[PULL] SH mobile LCDC cleanups and fixes"
> I've applied this series as it looks okay to me.

Thank you.

-- 
Regards,

Laurent Pinchart
