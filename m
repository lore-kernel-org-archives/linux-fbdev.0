From: Alex Deucher <agd5f@yahoo.com>
Subject: Re: [Linux-fbdev-devel] Re: [Dri-devel] Rage128 and Radeon patches
Date: Thu, 14 Aug 2003 11:06:07 -0700 (PDT)
Sender: devel-admin@XFree86.Org
Message-ID: <20030814180607.34519.qmail@web11305.mail.yahoo.com>
References: <20030814171311.84327.qmail@web14911.mail.yahoo.com>
Reply-To: devel@xfree86.org
Mime-Version: 1.0
Return-path: <devel-admin@XFree86.Org>
In-Reply-To: <20030814171311.84327.qmail@web14911.mail.yahoo.com>
Errors-To: devel-admin@XFree86.Org
List-Help: <mailto:devel-request@XFree86.Org?subject=help>
List-Post: <mailto:devel@XFree86.Org>
List-Subscribe: <http://XFree86.Org/mailman/listinfo/devel>,
	<mailto:devel-request@XFree86.Org?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://XFree86.Org/mailman/listinfo/devel>,
	<mailto:devel-request@XFree86.Org?subject=unsubscribe>
List-Archive: <http://XFree86.Org/mailman/private/devel/>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jon Smirl <jonsmirl@yahoo.com>, dri-devel <dri-devel@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: devel@xfree86.org

I haven't tried multiple radeon cards, but I seem to recall several
people having this problem right around when 4.3.0 was released.  I
don't think a "proper" fix ever went in and I think the issue was to be
revisited later.  I don't know if it's needed anymore or not.

Alex

--- Jon Smirl <jonsmirl@yahoo.com> wrote:
> --- Alex Deucher <agd5f@yahoo.com> wrote:
> > > 2) access ROM directly instead of relying on copy
> > > in low RAM. This allows multiple cards. Required
> > > MPP_TB_CONFIG fix in driver.
> > 
> > Is this patch necessary for xfree86?  It may address
> > some of the issues
> > in the email threads I sent out yesterday (ie,
> > problems with multiple
> > radeon cards and xfree86).  if so would you consider
> > making one?
> > 
> 
> Xfree code does not have the patch, but is Xfree
> experiencing the bug? Xfree accesses the hardware very
> differently than the framebuffer drivers.
> 
> I suspect that you would see this problem if you were
> using something else for your primary video and a
> Radeon for secondary. The first time you ran Xfree it
> would work. But when you exited and restarted Xfree it
> would hang when starting the secondary display.
> 
> Where does XFree reset the secondary card? The code
> below needs to run right after the reset in the radeon
> driver. I added it to my Rage128 driver too but I have
> not observed the problem with them.
> 
> Framebuffer code is different and triggers the bug the
> first time the secondary display is accessed.
> 
> /* Fix from ATI for problem with Radeon hardware not
> leaving ROM enabled */
> unsigned int temp;
> temp = INREG(RADEON_MPP_TB_CONFIG);
> temp &= 0x00ffffffu;
> temp |= 0x04 << 24;
> OUTREG(RADEON_MPP_TB_CONFIG, temp);
> temp = INREG(RADEON_MPP_TB_CONFIG);
> 
> 
> =====
> Jon Smirl
> jonsmirl@yahoo.com
> 

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
