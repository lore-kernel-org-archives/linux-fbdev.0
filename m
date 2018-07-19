From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Date: Thu, 19 Jul 2018 10:47:49 +0000
Subject: Re: [PATCH 0/6] vt: no blinking on console, 256/24-bit color improvements
Message-Id: <20180719114749.00a7f979@alans-desktop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180718030152.kdq53mwpdfusvwl5@angband.pl>
In-Reply-To: <20180718030152.kdq53mwpdfusvwl5@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adam Borowski <kilobyte@angband.pl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-console@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 18 Jul 2018 05:01:52 +0200
Adam Borowski <kilobyte@angband.pl> wrote:

> Hi!
> Here's a patchset with two entangled improvements:
> 
> * it'd be good to get rid of blinking where possible.  Even CGA (thus VGA)
>   allows disabling it, rendering such characters with a bright background
>   instead.

That's a matter of taste so needs to configurable. Changing the default
ought I think to be its own patch as it's a separate discussion to having
the choice there and easy to make.

For the palette why does it needs changing and exactly what standards
document defines 'right', especially given we don't do ICC in console
mode ? Have you tested the values used against multiple monitor types and
cards with a light meter ?

BTW visibly breaking the Nvidia crud is also fine. They'll then actually
bother to fix it and uually quite soon.

Alan


