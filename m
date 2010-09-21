From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Tue, 21 Sep 2010 05:56:10 +0000
Subject: Re: [Patch, RFC] Make struct fb_info ref-counted with kref
Message-Id: <20100921075610.1c016c12@pluto.restena.lu>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100919172833.14bf291e@neptune.home>
	<4C963E99.9080207@gmx.de>
	<20100919190240.65762511@neptune.home>
	<4C97B079.8050707@gmx.de>
	<20100920213258.1218b284@neptune.home>
	<4C97BF40.6030708@gmx.de>
	<20100920223608.19b4d177@neptune.home>
	<4C97E00B.6090103@gmx.de>
In-Reply-To: <4C97E00B.6090103@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Bernie Thompson <bernie@plugable.com>

On Tue, 21 Sep 2010 00:28:27 Florian Tobias Schandinat <FlorianSchandinat@gmx.de> wrote:
> > Tracking if/how often framebuffer is opened as such is a separate thing (though
> > all users that have the framebuffer opened hold a reference to fb_info).
> 
> That's what I said. So as long as refcount <= 1 it does not matter whether you 
> just count on open/release or additionally on every framebuffer operation, just 
> that the later produces more noise.

Hm, I don't count on every framebuffer operation... in most cases
fb_info is provided as function argument, in which case no further
counting is needed as the caller has a valid reference.

With my patch applied refcount for registered but unsed framebuffer was
2 (once for the driver, once for registered_fb entry) and went up to 3
when userspace opened framebuffer. fbcon's usage only incremented
refcount for very short timeframes when effectively using fb_info.

When starting with the FB minor I have to take a new reference.
(though I maybe should check if file's private data is set and use
that reference instead of looking up fb_info by minor as is currently
done)

For fbcon all the references are taken by FB minor (I wondered why
fbcon only remembers index into registered_fb aka minor instead of
fb_info itself)

> So I still don't see any advantage in counting users + uses.
> Please note that I do not object the idea of the patch itself, it's only that I 
> have a different preference on what to count. I only want to express that your 
> way is more complicated than what I would recommend.

I don't think I see how you would do the refcounting... would you just
drop the changes in fb_open() and fb_release()?
Could you describe your approach (with pseudo-code) or the differences
to mine?

Thanks,
Bruno


> But if you want to go on I do not object. As long as the end result works that's 
> okay with me.
> 
> 
> Thanks
> 
> Florian Tobias Schandinat
