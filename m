From: Frans Klaver <fransklaver@gmail.com>
Date: Mon, 26 Jun 2017 09:16:42 +0000
Subject: Re: [PATCH] staging: sm750fb: always take the lock
Message-Id: <CAH6sp9N621aYHde3Gfg=fxM8dCGzDYftP1_8EGQuwhJBj0kggg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1498455936-2108-1-git-send-email-abdallah.meziti.pro@gmail.com> <CAMuHMdUp2JQAYz3Smb4bH=SSc6tCb2iLQG1-5uQguz_wxyybfQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUp2JQAYz3Smb4bH=SSc6tCb2iLQG1-5uQguz_wxyybfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: AbdAllah-MEZITI <abdallah.meziti.pro@gmail.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, driverdevel <devel@driverdev.osuosl.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Jun 26, 2017 at 11:11 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Mon, Jun 26, 2017 at 7:45 AM, AbdAllah-MEZITI
> <abdallah.meziti.pro@gmail.com> wrote:
>> This patch
>> - will always take the lock
>
> Why?
>
> "The current code only takes the lock if multiple instances are in use.
>  This is error-prone, and confuses static analyzers.
>  As taking the lock in case of a single instance is harmful and cheap,
>  change the code to always take the lock."

I would argue that it's not harmful, lest people get confused about
it. And I agree that this explanation is much more useful than just
mentioning the warnings that you saw.

Thanks,
Frans
