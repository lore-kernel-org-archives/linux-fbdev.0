From: James Simmons <jsimmons@infradead.org>
Date: Fri, 02 Dec 2011 17:57:44 +0000
Subject: Re: QVGA on a hardware which supports only >= VGA
Message-Id: <alpine.LFD.2.02.1112021756530.13853@casper.infradead.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="1985284609-558930386-1322848664=:13853"
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAH9NwWdUZHfhqpNwcfxK_EnsMLeEazB50rQ=m65U3+tjhpwGJQ@mail.gmail.com>
In-Reply-To: <CAH9NwWdUZHfhqpNwcfxK_EnsMLeEazB50rQ=m65U3+tjhpwGJQ@mail.gmail.com>
To: linux-fbdev@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1985284609-558930386-1322848664=:13853
Content-Type: TEXT/PLAIN; charset="utf-8"
Content-Transfer-Encoding: 8bit

> 2011/11/18 Christian Gmeiner <christian.gmeiner@gmail.com>:
> > Hi all,
> >
> > I am currently in the process to get some local patches into mainline
> > and/or fix my
> > problems the right way. At the moment I am stuck with this problem:
> >
> > I am on a device (x86), which is Geode lx800 based and there is a
> > panel connected to
> > it. The problem is that two different screen resolutions are used. QVGA and VGA.
> > Should not sound like a problem, but the lx800 can only do VGA. So get
> > it working,
> > I need to pass the correct resolution via kernel cmd to the lxfb
> > driver and I am using
> > this patch (based on 2.6.36.4 kernel):
> >
> > --- a/drivers/video/fbmem.c
> > +++ b/drivers/video/fbmem.c
> > @@ -1050,6 +1050,7 @@ static long do_fb_ioctl(struct fb_info *info,
> > unsigned int cmd,
> >                ret = copy_to_user(argp, &var, sizeof(var)) ? -EFAULT : 0;
> >                break;
> >        case FBIOPUT_VSCREENINFO:
> > +#if 0
> >                if (copy_from_user(&var, argp, sizeof(var)))
> >                        return -EFAULT;
> >                if (!lock_fb_info(info))
> > @@ -1062,6 +1063,8 @@ static long do_fb_ioctl(struct fb_info *info,
> > unsigned int cmd,
> >                unlock_fb_info(info);
> >                if (!ret && copy_to_user(argp, &var, sizeof(var)))
> >                        ret = -EFAULT;
> > +#endif
> > +               ret = 0;
> >                break;
> >        case FBIOGET_FSCREENINFO:
> >                if (!lock_fb_info(info))
> > @@ -1086,6 +1089,7 @@ static long do_fb_ioctl(struct fb_info *info,
> > unsigned int cmd,
> >                ret = fb_cmap_to_user(&cmap_from, &cmap);
> >                break;
> >        case FBIOPAN_DISPLAY:
> > +#if 0
> >                if (copy_from_user(&var, argp, sizeof(var)))
> >                        return -EFAULT;
> >                if (!lock_fb_info(info))
> > @@ -1096,6 +1100,8 @@ static long do_fb_ioctl(struct fb_info *info,
> > unsigned int cmd,
> >                unlock_fb_info(info);
> >                if (ret == 0 && copy_to_user(argp, &var, sizeof(var)))
> >                        return -EFAULT;
> > +#endif
> > +               ret = 0;
> >                break;
> >        case FBIO_CURSOR:
> >                ret = -EINVAL;
> >
> > I need to mention that I am using a custom BIOS and Linux based
> > bootloader (kexec) in the
> > boot process. At the moment I am looking into coreboot, but I wanted
> > to know how to
> > solve this "problem" the correct way.
> >
> > To sum it up: I want to use a QVGA panel with a hardware that only
> > supports >= VGA.

That breaks the userland interface. What exactly is breaking? It looks 
like a userland app is causing the headaches.

--1985284609-558930386-1322848664=:13853--
