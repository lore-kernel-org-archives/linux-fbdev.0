From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 01 Mar 2011 18:29:23 +0000
Subject: Re: matroxfb: remove incorrect Matrox G200eV support
Message-Id: <AANLkTikwSXN8VgDaoUqfHcxoTNxW9uA4D2fUtRLuLbHo@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20110301175026.GA18770@us.ibm.com>
In-Reply-To: <20110301175026.GA18770@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Gary Hade <garyhade@us.ibm.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Darrick J. Wong" <djwong@us.ibm.com>, Krzysztof Helt <krzysztof.h1@wp.pl>, Petr Vandrovec <vandrove@vc.cvut.cz>, Andrew Morton <akpm@linux-foundation.org>

On Tue, Mar 1, 2011 at 9:50 AM, Gary Hade <garyhade@us.ibm.com> wrote:
>
> Remove incorrect Matrox G200eV support that was previously added
> by commit e3a1938805d2e81b27d3d348788644f3bad004f2

That commit goes back to 2.6.28 (and is dated Oct 2008).

That means that you really need to describe the problem more:

> One serious issue with the G200eV support that I have reproduced
> on a Matrox G200eV equipped IBM x3650 M2 is the lack of text (login
> banner, login prompt, etc) on the console when X not running and
> lack of text on all of the virtual consoles after X is started.

.. but without the commit, you get no fb at all, right? So even with
the commit, at worst you'd just be able to not use the matroxfb
driver, right?

What I'm trying to say is that I suspect there are G200eV users that
likely prefer having the support in - even though it's not perfect.
And the fact that the commit has been there for 2.5 years without
comments makes me very loath to just revert it.

                           Linus
