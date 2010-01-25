From: "Rick L. Vinyard, Jr." <rvinyard@cs.nmsu.edu>
Date: Mon, 25 Jan 2010 16:48:34 +0000
Subject: Re: [PATCH] hid: Logitech G13 driver 0.0.4
Message-Id: <acd6dfcf4391c081f861d430c0b45311.squirrel@intranet.cs.nmsu.edu>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201001202047.o0KKlMTr014003@mustang.cs.nmsu.edu>
    <201001202219.12058.oliver@neukum.org>
In-Reply-To: <201001202219.12058.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-kernel@vger.kernel.org, felipe.balbi@nokia.com, pavel@ucw.cz, jayakumar.lkml@gmail.com, linux-fbdev@vger.kernel.org, krzysztof.h1@wp.pl, akpm@linux-foundation.org, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, jkosina@suse.cz, dmitry.torokhov@gmail.com

Oliver Neukum wrote:
> Am Mittwoch, 20. Januar 2010 21:47:22 schrieb Rick L. Vinyard Jr.:
>> +       if (copy_from_user(dst, buf, count))
>> +               err = -EFAULT;
>> +
>> +       if (!err)
>> +               *ppos += count;
>> +
>> +       g13_fb_update(par);
>> +
>> +       return (err) ? err : count;
>
> Do you really want to go on if you get -EFAULT?
>

Since the hecubafb driver (which I based this portion of the g13 driver
on) uses the same approach I tried to justify it myself when I first saw
it.

I don't know if this was the intent of the hecubafb author, but this is
the way I saw it.

By this point the copy_from_user() has failed. If it resulted in a partial
copy to dst then continuing on to an update can't hurt, and would reduce
display jitter if a re-write occurs from userspace. If a re-write doesn't
occur the virtual framebuffer is hosed anyways as dst is is the underlying
framebuffer.

Given that, the worst-case consequence seems to be an unnecessary update
to the device display.


