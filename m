From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Fri, 26 Oct 2012 13:37:54 +0000
Subject: Re: tty, vt: lockdep warnings
Message-Id: <20121026143754.50277bd8@pyramind.ukuu.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <50899507.1040900@oracle.com>
In-Reply-To: <50899507.1040900@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sasha Levin <sasha.levin@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dave Jones <davej@redhat.com>, linux-fbdev@vger.kernel.org, florianSchandinat@gmx.de

On Thu, 25 Oct 2012 15:37:43 -0400
Sasha Levin <sasha.levin@oracle.com> wrote:

> Hi all,
> 
> While fuzzing with trinity inside a KVM tools (lkvm) guest running latest -next kernel,
> I've stumbled on the following spew:

Looks real enough but its not a tty/vt layer spew. This is all coming out
of the core framebuffer code which doesn't seem to be able to decide what
the locking rules at the invocation of fb_notifier_call_chain are.

It might need some console layer tweaking to provide 'register console
and I already hold the locks' or similar but that notifier needs some
kind of sanity applying as well.

Cc'ing the fbdev folks

Alan
