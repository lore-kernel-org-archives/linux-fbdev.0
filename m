From: James Simmons <jsimmons@infradead.org>
Subject: Re: xxx_check_var
Date: Tue, 10 Dec 2002 22:32:31 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.33.0212102219010.2617-100000@maxwell.earthlink.net>
References: <1039562028.3373.32.camel@zion>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <1039562028.3373.32.camel@zion>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net


> > When I look at atyfb_check_var or aty128fb_check_var, I see that they
> > will alter the contents of *info->par.  Isn't this a bad thing?  My
>
> Yes, this wrong, and afaik, it's your original port to 2.5 that did that
> ;)

Yeap. The idea of check_var is to validate a mode. Note modedb uses just
check_var. It is okay to READ the values in your par. You shouldn't alter
the values in par.

> > understanding was that after calling check_var, you don't necessarily
> > call set_par next (particularly if check_var returned an error).

Correct. Check_var is always called. Now if you wanted to just test a mode
via userland with the FB_ACTIVATE_TEST flag then only fb_check_var is
called. If you pass in FB_ACTIVATE_NOW then both fb_check_var and
fb_set_par will be called. Fb_set_par actually sets the hardware state.

> > Also I notice that atyfb_set_par and aty128fb_set_par don't look at
> > info->var, they simply set the hardware state based on the contents of
> > *info->par.
>
> Which is wrong too indeed

Actually you can look at info->var. Info->var has been validated so it can
be trusted. You don't need to stuff everything into par. You DO need to
change info->fix if the hardware state has changed.

> > Looking at skeletonfb.c, it seems that this is the wrong behaviour.  I
> > had fixed the aty128fb.c driver in the linuxppc-2.5 tree.  James, if
> > you let me know whether the current behaviour is wrong or not, I'll
> > fix them and send you the patch.

I hope me input helped.

BTW docs are on the way. I will work with Steven Luther on this the next
couple of days.

> I _think_ my radeonfb (in linuxppc-2.5) is right in this regard too.
> Look at the initialization too, iirc, you had some non necessary stuff
> in there (calling gen_set_disp, gen_set_var is plenty enough).

You go the logic down.

P.S

 For the pmu_sleep_notifier can you pass in a specific struct fb_info or
do you need to make a list of all of them?
