From: DANTE JAVIER PAZ <dpaz@unc.edu.ar>
Date: Mon, 11 Mar 2019 20:32:11 +0000
Subject: Re: [PATCH] FBTFT: fbtft-bus: Fix code style problems
Message-Id: <CAJdeGOTPLoSwQ9hb7Tk_cZ+VmT-xvEtGU_pbSUXoxcB20d3rcw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190309214852.12233-1-dante.paz@gmail.com>
 <20190311162527.GA20652@ravnborg.org>
In-Reply-To: <20190311162527.GA20652@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: devel@driverdev.osuosl.org, leobras.c@gmail.com, linux-fbdev@vger.kernel.org, nishadkamdar@gmail.com, gregkh@linuxfoundation.org, Dante Paz <dante.paz@gmail.com>, dri-devel@lists.freedesktop.org, renatoys08@gmail.com

Hello Sam, thank you very much for your comments,
As I told Dan (my email did not reach the mailing list) this is my
first attempt to contribute,
So I'm learning a lot from your advice and corrections.

I will look for TODO lists to see if there are more useful
contributions to make, all suggestions are also welcome.

Thanks again for the patience of all of you.
Best,
Dante


El lun., 11 mar. 2019 a las 13:25, Sam Ravnborg (<sam@ravnborg.org>) escribió:
>
> Hi Dante
>
> Thanks for the patch.
> On Sat, Mar 09, 2019 at 06:48:52PM -0300, Dante Paz wrote:
> > From: Dante Paz <dpaz@unc.edu.ar>
> >
> >     Style and coding function issues were corrected, by avoiding macro functions with a conflicting coding style.
> >     Signed-off-by: Dante Paz <dpaz@unc.edu.ar>
>
> But it raised a few comments.
>
> The staging/fbtft is a dumping of a set of drivers that
> in the end will be migrated to DRM.
> And there is not much gained trying to do coding style changes to these
> drivers.
> So please conmsider finding a drver where this is more relevant.
>
> Furthermore that patch presented is hard to review as it contains
> too much changes in one go.
> As a rule of thumb include only one type of change per patch.
> This is worth to keep in mind for future submissions.
>
> It it then also good to present the trivial changes first(*), and the
> less trivial changes later.
>
> (*) Like whitespace to tabs, spellign errors etc.
>
>         Sam



-- 
-- 
Dr. Dante Javier Paz
Instituto de Astronomía, Teórica y Experimental, IATE
Observatorio Astronómico de Córdoba

Tel: (54) 351-5353776 ext 75643
Web: www.iate.oac.uncor.edu


Laprida 854
X5000BGR - Córdoba
ARGENTINA
