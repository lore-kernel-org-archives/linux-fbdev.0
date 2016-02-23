From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 23 Feb 2016 09:34:46 +0000
Subject: Re: [PATCH 11/11] ARM: versatile: move CLCD configuration to device tree
Message-Id: <3695074.sKSIyOjpjD@wuerfel>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <1454594660-7532-12-git-send-email-linus.walleij@linaro.org>
 <CACRpkdbnLgVsrSAu87wxSwktK3ftJzbQLXjU8y65tq=9Ynxicw@mail.gmail.com>
In-Reply-To: <CACRpkdbnLgVsrSAu87wxSwktK3ftJzbQLXjU8y65tq=9Ynxicw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tuesday 23 February 2016 10:08:05 Linus Walleij wrote:
> I will think of a better solution, if any, for this for v4.6, but will
> put forward something that handles the Nomadik and all the
> other ARM reference designs for now.
> 

How about still describing all known panels in the DT marked 'status="disabled"',
but then having a minimal piece of board specific code that just enables
whichever one gets detected at boot time?

	Arnd
