From: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video card BOOT?
Date: 15 Oct 2004 15:13:13 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <87y8i8p1jq.fsf@bytesex.org>
References: <416E6ADC.3007.294DF20D@localhost> <87d5zkqj8h.fsf@bytesex.org>
	<Pine.GSO.4.61.0410151437050.10040@waterleaf.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S267882AbUJONpS@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.61.0410151437050.10040@waterleaf.sonytel.be>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>, penguinppc-team@lists.penguinppc.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> On Fri, 15 Oct 2004, Gerd Knorr wrote:
> > Have you talked to the powermanagement guys btw.?  One of the major
> > issues with suspend-to-ram is to get the graphics card back online,
> > and SNAPBoot might help to fix this too.  I'm not sure a userspace
> > solution would work for *that* through.
> 
> Why not? Of course you won't get any output before the graphics card has been
> re-initialized to a sane and usable state...

You have a application running which uses the framebuffer device, then
suspend with that app running.  You'll have to restore the state of
the device _before_ restarting all the userspace proccesses, otherwise
the app will not be very happy.  I'm not sure if the kernel can run a
userspace helper in that situation (i.e. before waking all the
processes).

  Gerd

-- 
return -ENOSIG;
