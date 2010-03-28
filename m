From: "Justin P. mattock" <justinmattock@gmail.com>
Date: Sun, 28 Mar 2010 19:08:41 +0000
Subject: Re: [PATCH] Rename imacfb.txt to efifb.txt and change imacfb to
Message-Id: <4BAFA939.7080000@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1269798210-8664-1-git-send-email-justinmattock@gmail.com> <10f740e81003281154i4885f559s3f6ac79f1e697a3e@mail.gmail.com>
In-Reply-To: <10f740e81003281154i4885f559s3f6ac79f1e697a3e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 03/28/2010 11:54 AM, Geert Uytterhoeven wrote:
> On Sun, Mar 28, 2010 at 19:43, Justin P. Mattock
> <justinmattock@gmail.com>  wrote:
>> Rename imacfb.txt to efifb.txt since imacfb was moved to
>> efifb,and change imacfb to efifb.
>> Note:I used git rm for imacfb.txt, but
>> git renamed this file to efifb.txt after everything was said and
>> done, not sure if this is correct or not.
>
> Git doesn't track renames. It just notices a new file is very similar
> (in this case identical)
> to a deleted one.
>
> Gr{oetje,eeting}s,
>
> 						Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
>

that's what happened i.g. I did git rm imacfb.txt
then did a git add efifb.txt
then git commit
then git said rename in the end

I've never submitted an add/delete so hopefully
this is o.k.

Justin P. Mattock
