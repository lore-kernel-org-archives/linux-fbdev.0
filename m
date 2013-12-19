From: David Herrmann <dh.herrmann@gmail.com>
Date: Thu, 19 Dec 2013 12:36:38 +0000
Subject: Re: cirrusdrmfb broken with simplefb
Message-Id: <CANq1E4TW3O9czVzX1bj4F5oMrDHZ+ZsLHLCk9ANsg2e14QXmfg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <s5hlhzik3kk.wl%tiwai@suse.de>
	<CANq1E4TFKDduy71jCXy+8CMS1_OFxWEpsHY3AA0RUJPW4VE8hg@mail.gmail.com>
	<20131218092941.GA19210@gmail.com>
	<20131219000346.0f722b65@alan.etchedpixels.co.uk>
	<CANq1E4Q3KiLMC-ETFs+FAmTv3yWdCyqG2c+KzGFX4xZmcxLbJg@mail.gmail.com>
	<s5h61qlt7zm.wl%tiwai@suse.de>
In-Reply-To: <s5h61qlt7zm.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Takashi Iwai <tiwai@suse.de>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>

Hi

On Thu, Dec 19, 2013 at 12:06 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Thu, 19 Dec 2013 11:46:51 +0100,
> David Herrmann wrote:
>>
>> Hi
>>
>> On Thu, Dec 19, 2013 at 1:03 AM, One Thousand Gnomes
>> <gnomes@lxorguk.ukuu.org.uk> wrote:
>> >> > That bug always existed, simplefb is just the first driver to hit it
>> >> > (vesafb/efifb didn't use resources). I'm aware of the issue but as a
>> >> > workaround you can simply disable CONFIG_X86_SYSFB. That restores
>> >> > the old behavior.
>> >>
>> >> This looks like a regression, so we'll either need a fix or we'll have
>> >> to mark CONFIG_X86_SYSFB as CONFIG_BROKEN.
>> >
>> > Kernel bugzilla has entries for simplefb breaking both vesafb and matrox
>> > mga.
>>
>> Thanks for the hints. I've read through all I could find and tried to
>> provide some help.
>>
>> I'm kind of confused, most of them enable CONFIG_X86_SYSFB (which is
>> 'n' by default) but don't read the help text. I did my best to tell
>> people that this option requires CONFIG_FB_SIMPLE, but if you don't
>> read the help-text you won't notice that. Don't know what to do about
>> that..
>
> You can set FB_SIMPLE default value depending on X86_SYSFB, something
> like:
>
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -2455,6 +2455,7 @@ config FB_HYPERV
>  config FB_SIMPLE
>         bool "Simple framebuffer support"
>         depends on (FB = y)
> +       default y if X86_SYSFB
>         select FB_CFB_FILLRECT
>         select FB_CFB_COPYAREA
>         select FB_CFB_IMAGEBLIT

The "default <wx> if <yz>" only works if the config hasn't been set at
all, yet. Even a "# CONFIG_* is unset" causes the "default" value to
be ignored.

How about adding "depends on (FB_SIMPLE = y)" for X86_SYSFB? I guess I
will try that and send a patch.

Thanks
David
