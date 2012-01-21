From: Manuel Lauss <manuel.lauss@googlemail.com>
Date: Sat, 21 Jan 2012 14:00:46 +0000
Subject: Re: [PATCH 2/4] drivers/video/au*fb.c: use devm_ functions
Message-Id: <CAOLZvyGujvpnCFxe7x82Y91kRRNM1-P165jMXXWryFqY3g-RXw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1327094732-9050-1-git-send-email-Julia.Lawall@lip6.fr>
 <1327094732-9050-3-git-send-email-Julia.Lawall@lip6.fr> <4F1AC33E.90405@gmx.de>
In-Reply-To: <4F1AC33E.90405@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>, kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Hello,

On Sat, Jan 21, 2012 at 2:53 PM, Florian Tobias Schandinat
<FlorianSchandinat@gmx.de> wrote:
> [CC'ing Manuel Lauss as he knows those drivers better than I do]
>
> On 01/20/2012 09:25 PM, Julia Lawall wrote:
>> From: Julia Lawall <Julia.Lawall@lip6.fr>
>>
>> The various devm_ functions allocate memory that is released when a driv=
er
>> detaches. =A0This patch uses these functions for data that is allocated =
in
>> the probe function of a platform device and is only freed in the remove
>> function.
>>
>> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>>
>> ---
>> In the case of au1100fb.c, should the failed label return something other
>> than 0?
>> In the case of au1200fb.c, should the error-handling code under the new
>> call to dma_alloc_noncoherent jump to failed, like the other error handl=
ing
>> code? =A0I was not sure that there was actually anything for failed to d=
o at
>> this point in the function.
>
> Maybe Manuel is able to answer these questions. I've queued this patch an=
d if he
> doesn't respond I'll apply it after some time.

au1100fb:  Yes, a -ENODEV instead of 0 in the error case is probably a
good idea.
au1200fb:  The error path(s) are buggy; they don't free all windows if
creation of
                      the 4th fails for example. It has been this way
since the driver appeared
                      but for all current use cases (demoboards and in
the field) it actually works.
                      I'm working on a rewrite which is however
progressing rather slowly.


>> =A0drivers/video/au1100fb.c | =A0 30 +++++++++++-------------------
>> =A0drivers/video/au1200fb.c | =A0 =A09 +--------
>> =A02 files changed, 12 insertions(+), 27 deletions(-)

Acked-by: Manuel Lauss <manuel.lauss@googlemail.com>

[...]

Thanks!
      Manuel Lauss
