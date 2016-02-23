From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 23 Feb 2016 11:22:34 +0000
Subject: Re: [PATCH 11/11] ARM: versatile: move CLCD configuration to device tree
Message-Id: <6859810.tb1t0IEONi@wuerfel>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <3695074.sKSIyOjpjD@wuerfel>
 <CACRpkdZjfjOCFUucF1U5yVZBxSwa41GKEMv-HHQE=ymF2NZ21g@mail.gmail.com>
In-Reply-To: <CACRpkdZjfjOCFUucF1U5yVZBxSwa41GKEMv-HHQE=ymF2NZ21g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tuesday 23 February 2016 11:10:33 Linus Walleij wrote:
> 
> ERROR (duplicate_label): ERROR (duplicate_label): Duplicate label
> 'clcd_panel' on /panel@1/port/endpoint and /panel@0/port/endpoint
> Duplicate label 'clcd_panel' on /panel@1/port/endpoint and
> /panel@0/port/endpoint
> 
> So the dtc does not allow duplicate node labels for the phandle
> even if the node it resides in is disabled. Tough luck...

Ah, too bad. I guess we could still do it by also setting the
remote-endpoint property to node->phandle, but then it's
not as simple any more.

	Arnd
