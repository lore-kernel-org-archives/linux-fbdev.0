From: Doug Anderson <dianders@google.com>
Date: Tue, 23 Feb 2016 03:03:44 +0000
Subject: Re: [PATCH v3 00/12] pwm: add support for atomic update
Message-Id: <CAD=FV=WP+=vsKHj3aakdYwE4Xedwd=uya+ma22q-s+MsBTon7w@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1442828009-6241-1-git-send-email-boris.brezillon@free-electrons.com>
 <2341981.a79ioYM9Es@diego> <20151110173416.GB21727@ulmo>
 <CAD=FV=WL3jYEgVe-m6QcAyQwfJgdX4J5OtKisKwyoKOrTSpEQA@mail.gmail.com>
 <20160125170855.GA10182@ulmo>
 <CAD=FV=Xvxeqo3imUmjukC5iYk3EZkrJ04G7C1B-w4xyr-r6-2Q@mail.gmail.com>
 <20160203145337.GD9650@ulmo>
 <CAD=FV=U_x1cxx6RrHuVgVV8GbOwm9DXXJcyiArbbQySUOaxrvQ@mail.gmail.com>
 <20160222175929.GA23899@ulmo>
 <CAD=FV=UCErW3EjYRtwt49_ztNR7cyY4U0o4R_dxdomer-Ac2Dg@mail.gmail.com>
 <20160222212438.GG18327@sirena.org.uk>
In-Reply-To: <20160222212438.GG18327@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Mark,

On Mon, Feb 22, 2016 at 1:24 PM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Feb 22, 2016 at 11:15:09AM -0800, Doug Anderson wrote:
>
>> Note that historically I remember that Linus Torvalds has stated that
>> there is no stable API within the Linux kernel and that forcing the
>> in-kernel API to never change was bad for software development.  I
>> tracked down my memory and found
>> <http://lwn.net/1999/0211/a/lt-binary.html>.  Linus is rabid about not
>> breaking userspace, but in general there's no strong requirement to
>> never change the driver API inside the kernel.  That being said,
>> changing the driver API causes a lot of churn, so presumably changing
>> it in a backward compatible way (like adding to the API instead of
>> changing it) will make things happier.
>
> You do need to fix the users though, change is fine but you can't cause
> people's systems to break.

Yes, of course!  :)  Thanks for clarifying.

-Doug
