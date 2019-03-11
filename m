From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 11 Mar 2019 16:25:27 +0000
Subject: Re: [PATCH] FBTFT: fbtft-bus: Fix code style problems
Message-Id: <20190311162527.GA20652@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190309214852.12233-1-dante.paz@gmail.com>
In-Reply-To: <20190309214852.12233-1-dante.paz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dante Paz <dante.paz@gmail.com>
Cc: devel@driverdev.osuosl.org, Dante Paz <dpaz@unc.edu.ar>, linux-fbdev@vger.kernel.org, nishadkamdar@gmail.com, leobras.c@gmail.com, gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org, renatoys08@gmail.com

Hi Dante

Thanks for the patch.
On Sat, Mar 09, 2019 at 06:48:52PM -0300, Dante Paz wrote:
> From: Dante Paz <dpaz@unc.edu.ar>
> 
>     Style and coding function issues were corrected, by avoiding macro functions with a conflicting coding style.
>     Signed-off-by: Dante Paz <dpaz@unc.edu.ar>

But it raised a few comments.

The staging/fbtft is a dumping of a set of drivers that
in the end will be migrated to DRM.
And there is not much gained trying to do coding style changes to these
drivers.
So please conmsider finding a drver where this is more relevant.

Furthermore that patch presented is hard to review as it contains
too much changes in one go.
As a rule of thumb include only one type of change per patch.
This is worth to keep in mind for future submissions.

It it then also good to present the trivial changes first(*), and the
less trivial changes later.

(*) Like whitespace to tabs, spellign errors etc.

	Sam
