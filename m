From: Jaya Kumar <jayakumar.lkml@gmail.com>
Date: Mon, 10 May 2010 00:00:51 +0000
Subject: Re: Deadlock between fbcon and fb_defio?
Message-Id: <AANLkTik0EkPYKdnhrpF7yK6eXIrHMsNYrzSC6tyeBR0P@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100509184911.3f136b77@neptune.home>
In-Reply-To: <20100509184911.3f136b77@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

On Mon, May 10, 2010 at 12:49 AM, Bruno Pr=E9mont
<bonbons@linux-vserver.org> wrote:
>
> Fix crash if we are the first framebuffer loaded as in that case fbcon
> wants to flush framebuffer at the end of fb registration, before we
> have setup fb_defio.

Bruno,

Please help me understand, how does this scenario occur? I'm
interpreting what you've written above to mean that fbcon is accessing
the framebuffer before you've called defio_init()? Is that correct?

The typical defio use sequence is: defio_init(),
register_framebuffer() and the typical remove sequence is in the
reverse order unregister_framebuffer(), defio_cleanup(). So, I don't
see how fbcon is accessing the framebuffer either before
register_framebuffer() completes (at which point defio init is already
done) or after unregister_framebuffer() completes.

Thanks,
jaya
