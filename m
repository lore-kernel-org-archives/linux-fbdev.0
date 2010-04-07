From: Kevin Hilman <khilman@deeprootsystems.com>
Date: Wed, 07 Apr 2010 21:16:37 +0000
Subject: Re: [PATCH v3 1/1] DA8XX/OMAP-L1XX: FB: Implement double buffering
Message-Id: <876343arpm.fsf@deeprootsystems.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <A24693684029E5489D1D202277BE89445316FACC@dlee02.ent.ti.com>
In-Reply-To: <A24693684029E5489D1D202277BE89445316FACC@dlee02.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

"Ambrose, Martin" <martin@ti.com> writes:

> On Mon, Apr 05, 2010 at 17:35:38, Kevin Hilman wrote:
>
>> "Ambrose, Martin" <martin@ti.com> writes:
>> 
>> > This work includes the following:
>> >  . Implement handler for FBIO_WAITFORVSYNC ioctl.
>> >
>> >  . Allocate the data and palette buffers separately.
>> >    A consequence of this is that the palette and data loading is now
>> >    done in different phases. And that the LCD must be disabled
>> >    temporarily after the palette is loaded but this will only happen
>> >    once after init and each time the palette is changed. I think this
>> >    is OK.
>> >
>> >  . Allocate two (ping and pong) framebuffers from memory.
>> >
>> >  . Add pan_display handler which toggles the LCDC DMA registers between
>> >    the ping and pong buffers.
>> >
>> > Signed-off-by: Martin Ambrose <martin@ti.com>
>> 
>> Your mailer (probably outlook) is converting all tabs to spaces
>> resulting in a patch that wont apply.
>> 
>> I recommend using git-format-patch + git-send-email directly to your
>> SMTP server to avoid outlook mangling.
>
> Sorry about this but I'm floundering. The problem I'm having is that my git-send-email
> is being rejected by several of the recipients on this thread (notably linux-fbdev).
> The reason is that their servers perform sender verification which is fair and understandable.
> See my first attempt at sending the patch which made it to davinci-linux-open-source but
> not fbdev. My attempt at a solution was to first send it to my corporate account, which doesn't
> verify the address, then forward from Outlook. But this is non-functional as you pointed out.
>
> I am not an email expert by any means and don't know how to test different options without
> spamming the mailing lists with test emails. The root cause, I think, is that even though
> I am using git-send-email with the .gitconfig pointing to our corporate mail server the resultant
> header (or maybe ID) is not passing the verification step on the receiving end. 
>
> I have tried from both within cygwin and linux running under VMWare. Next step will be
> to try and send from a real linux machine on the corporate network but I'm doubting this
> will resolve the problem. And/or see if I can script Outlook to not convert whitespace --
> this I can test without annoying others.

Not sure what is going wrong, but I know that there are many folks
inside TI who are using git-send-email successfully.  Maybe ask
around.

Alternatively, you could use a gmail account as well.  See this
GitTips page where it describes how to send using gmail:

   https://git.wiki.kernel.org/index.php/GitTips#Mail

Kevin

