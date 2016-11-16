From: Manuel =?ISO-8859-1?Q?Sch=F6lling?= <manuel.schoelling@gmx.de>
Date: Wed, 16 Nov 2016 17:40:19 +0000
Subject: Re: [PATCH v3] console: Add persistent scrollback buffers for all VGA consoles
Message-Id: <1479318019.20980.12.camel@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1474236417-27150-1-git-send-email-manuel.schoelling@gmx.de>
         <20161110214748.GB26324@dell-m4800.home>
In-Reply-To: <20161110214748.GB26324@dell-m4800.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrey Utkin <andrey_utkin@fastmail.com>
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, jslaby@suse.cz, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

I finally found the time to rework the patches, but there are a few
things I want to discuss:

> > This breaks tools like clear_console that rely on flushing the
> > scrollback history by switching back and forth between consoles
> > which is why this feature is disabled by default.
> > Use the escape sequence \e[3J instead for flushing the buffer.
> 
> Have never heard of such tool as clear_console. Why mention it at all,
> where is it used, which are practical configurations which are broken in
> this way?
clear_console(1) is part of Debian's bash package and (I think) a
inofficial 'downstream' patch developed by Ubuntu [1]. There has been
security concerns (which is also why I disabled this feature by
default).
However, if there might be security issues, I would strongly suggest to
keep this part in the documentation - it does no harm anyway, does it?

> Does this break clear(1)?
No, my tests with clear(1) worked fine.

> > -         Enter the amount of System RAM to allocate for the scrollback
> > -	 buffer.  Each 64KB will give you approximately 16 80x25
> > -	 screenfuls of scrollback buffer
> > +	  Enter the amount of System RAM to allocate for scrollback
> > +	  buffers of VGA consoles. Each 64KB will give you approximately
> > +	  16 80x25 screenfuls of scrollback buffer.
> 
> Indentation amended, I don't know which way it should be, please
> double-check or mimic old indentation to stay on safe side.
Double-checked! That's at least how I read the docs.

> > +static struct vgacon_scrollback_info *vgacon_scrollback_cur;
> 
> Could you use name vgacon_scrollback instead of new
> vgacon_scrollback_cur? It doesn't change anything conceptually, but is a
> bit shorter and seems to mean current scrollback context anyway, right?
> 
> I think I see nothing to comment on below.
There is a already an array called 'vgacon_scrollbacks[N]', so I would
not like to have two variables named 'vgacon_scrollback' and
'vgacon_scrollbacks'. Either {'vgacon_scrollback_cur' and
'vgacon_scrollbacks'} or {'vgacon_scrollback' and
'vgacon_scrollback_list'}.
You can make a suggestion, if you like.

All other point you mentioned where fixed as you suggested.

Thanks again for your help, Andrey!

Best,

Manuel

[1]
http://manpages.ubuntu.com/manpages/xenial/en/man1/clear_console.1.html


