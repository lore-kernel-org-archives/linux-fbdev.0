From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 15 Aug 2013 06:02:16 +0000
Subject: Re: Changing which device has VTs?
Message-Id: <CALCETrW8jmNrc+6bhyiDZ8oXfL_+5_YHnsCJRjWGogCtaWquMg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CALCETrX5_CAREEPSWkwE6+bY+w+c_qJcYBVM7Nx16_URZ9Gn5A@mail.gmail.com>
In-Reply-To: <CALCETrX5_CAREEPSWkwE6+bY+w+c_qJcYBVM7Nx16_URZ9Gn5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wed, Aug 14, 2013 at 10:49 PM, Dave Airlie <airlied@gmail.com> wrote:
> (resend, gmail went html again).

And gmail broke pgdn, too :(

>
> On Thu, Aug 15, 2013 at 4:47 AM, Andy Lutomirski <luto@amacapital.net> wrote:
>> I have a box with a real graphics card (radeon) and an onboard
>> graphics card (mgag200).  I want to use the radeon and ignore the
>> mgag200.  For reasons of extreme firmware suckage, I have two choices:
>>
>> 1. Leave both devices enabled in BIOS and set the mgag200 device
>> primary.  This causes efifb and later mgag200 to both point at the
>> mgag200.  All of my text consoles end up on the mgag200.  This is
>> unfortunate, especially because if, even if I set xorg to ignore the
>> mgag200 device, hitting ctrl-alt-f2 causes X to suspend itself and my
>> text console to show up on a device with no monitor attached.
>>
>> 2. Set the radeon device as primary in BIOS.  System doesn't boot.
>
> get vendor to fix BIOS :-)

Done :)  (I'm now running some mysterious unreleased BIOS -- it's
vastly superior.)

>
>>
>> I'd like to leave mgag200 primary but tell Linux to put all the text
>> consoles on the radeon device once it shows up.  I could compile out
>> both efifb and mgag200, but that seems like a waste.  Is there any way
>> to do this with a command-line parameter?  I tried fbcon=map:1, and I
>> get no fbcon at all.
>
> the mapping stuff should work, alternative is to write some code to
> call the fbcon
> event, FB_EVENT_REMAP_ALL_CONSOLE, which is what the GPU switcher
> code uses to remap fbcon between switchable GPU systems.

Blech.  Fortunately, my new BIOS works and I can stop worrying.
(Plymouth is still broken -- separate bug filed.)

--Andy

>
> Dave.



-- 
Andy Lutomirski
AMA Capital Management, LLC
