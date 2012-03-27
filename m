From: "Mahapatra, Chandrabhanu" <cmahapatra@ti.com>
Date: Tue, 27 Mar 2012 11:37:30 +0000
Subject: Re: [PATCH V2 2/3] OMAPDSS: DISPC: Handle synclost errors in OMAP3
Message-Id: <CAF0AtAvSwwhVrf1Qa7dZfiai15XUUYoU3H+mPND9yYD2vLYC3w@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1332323516-9050-1-git-send-email-cmahapatra@ti.com>
	<1332845034.1867.116.camel@deskari>
	<CAF0AtAsfE4xjiLOcvmPB4KCJn4QjN+PumJWQEM3m6ZziK4zhVw@mail.gmail.com>
	<1332846616.1867.132.camel@deskari>
In-Reply-To: <1332846616.1867.132.camel@deskari>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-fbdev@vger.kernel.org

On Tue, Mar 27, 2012 at 4:40 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wro=
te:
> On Tue, 2012-03-27 at 16:31 +0530, Mahapatra, Chandrabhanu wrote:
>> On Tue, Mar 27, 2012 at 4:13 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> =
wrote:
>> > Hi,
>> >
>> > On Wed, 2012-03-21 at 15:21 +0530, Chandrabhanu Mahapatra wrote:
>> >> In OMAP3 DISPC video overlays suffer from some undocumented horizonta=
l position
>> >> and timing related limitations leading to SYNCLOST errors. Whenever t=
he image
>> >> window is moved towards the right of the screen SYNCLOST errors become
>> >> frequent. Checks have been implemented to see that DISPC driver rejec=
ts
>> >> configuration exceeding above limitations.
>> >>
>> >> This code was successfully tested on OMAP3. This code is written base=
d on code
>> >> written by Ville Syrj=E4l=E4 <ville.syrjala@nokia.com> in Linux OMAP =
kernel. Ville
>> >> Syrj=E4l=E4 <ville.syrjala@nokia.com> had added checks for video over=
lay horizontal
>> >> timing and DISPC horizontal blanking length limitations.
>> >>
>> >> Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
>> >> ---
>> >> =A0drivers/video/omap2/dss/dispc.c | =A0 97 +++++++++++++++++++++++++=
++++----------
>> >> =A01 files changed, 72 insertions(+), 25 deletions(-)
>> >
>> > The patch seems to be using dos line endings... Where did they come
>> > from? The two others are fine. I think git am removed the dos line
>> > endings, so it's fine.
>> >
>>
>> How did you find these errors? scripts/checkpatch.pl still returns me no=
thing.
>
> Well I just saved the email and ran checkpatch. Could be a problem in
> gmail or my end too, but I've never seen it happen before.
>
> =A0Tomi
>
Save it as text file and then run checkpatch it wont give any errors.
By default it tries to save it as a eml file. Just check it.


--=20
Chandrabhanu Mahapatra
Texas Instruments India Pvt. Ltd.
