From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Mon, 20 Sep 2010 20:36:08 +0000
Subject: Re: [Patch, RFC] Make struct fb_info ref-counted with kref
Message-Id: <20100920223608.19b4d177@neptune.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100919172833.14bf291e@neptune.home>
	<4C963E99.9080207@gmx.de>
	<20100919190240.65762511@neptune.home>
	<4C97B079.8050707@gmx.de>
	<20100920213258.1218b284@neptune.home>
	<4C97BF40.6030708@gmx.de>
In-Reply-To: <4C97BF40.6030708@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Bernie Thompson <bernie@plugable.com>

On Mon, 20 September 2010 Florian Tobias Schandinat <FlorianSchandinat@gmx.de> wrote:
> Bruno Prémont schrieb:
> > On Mon, 20 September 2010 Florian Tobias Schandinat <FlorianSchandinat@gmx.de> wrote:
> >> Bruno Prémont schrieb:
> >>> On Sun, 19 September 2010 Florian Tobias Schandinat <FlorianSchandinat@gmx.de> wrote:
> >>>> Bruno Prémont schrieb:
> >>>>> If you have concerns regarding the API changes, please let me know.
> >>>> Uhm, I'm not really happy with what we count. With the old method you mentioned 
> >>>> we ref-counted framebuffer users, after your patch it's more counting users + 
> >>>> uses. This might be okay as we usually are interested whether the ref_count is 0 
> >>>> or not but it doesn't look right if we modify the refcount during nearly every 
> >>>> framebuffer operation. Wouldn't it be sufficient to do the refcounting in 
> >>>> fb_open & fb_release operation + in fbcon where open&release are done?
> >>> Well I'm more for counting the uses, (especially as the aim is to not
> >>> force the driver to look exactly when it can free the fb_info struct).
> >>> If the driver needs to know about active users (e.g. for handling memory
> >>> reorganization on mode change or the like) that would remain driver's job.
> >> I don't see how your counting would influence the time fb_info is freed. It is 
> >> freed when the last reference is gone but the last remaining reference is always 
> >>   a user reference either from the framebuffer itself or from any user. But all 
> >> users have to keep the framebuffer open to do anything with it therfore the last 
> >> thing they do is releasing the framebuffer. So I do not really understand your 
> >> reasoning, for me counting the users + uses is more error prone than just the 
> >> users. But that's not important for me as I'm only interested in whether the 
> >> count is 0, 1 or more (want to turn off the screen if there are no active [=1] 
> >> users) which is the same regardless on what you count. So if you really want to 
> >> stick to your way of counting, that's no problem for me.
> > 
> > In case of picoLCD driver (which uses a shadow framebuffer in system RAM) the
> > last user can be a (userspace) process as on unplug driver unregisters that
> > framebuffer and hands back it's own reference, the fb_destroy callback being
> > in charge of freeing the shadow framebuffer when fb_info is being freed.
> 
> True. I think I understand the problem you want to solve.
> My question is:
> Do you keep a reference for each successful open operation until a release is done?
> If I read your patch correctly, the answer is yes.

The reference already exists now (fb_info being assigned to file->private_data),
but is not being accounted.

> Than the operations/counting you do between such operations should be irrelevant 
> to when the free is performed or?
> So the free is done either when the framebuffer releases its handle or (in your 
> case) when the process closes the file and therefore calls fb_release. Or do you 
> have any way to perform framebuffer operations without an open framebuffer?

Yes, the idea is to free fb_info when the last reference to it is being dropped
not matter who does it (device file closed or driver cleaning up or whoever else).
And do this without great complexity for the driver (fb_release callback not
allowing driver to free fb_info inside of callback).

Tracking if/how often framebuffer is opened as such is a separate thing (though
all users that have the framebuffer opened hold a reference to fb_info).

Unless I missed something only kernel-side code (driver itself) can operate on the
framebuffer without opening it, e.g. as it does for initial setup or when it
eventually reacts on some device events like monitor (un)plug)

Thanks,
Bruno
