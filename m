From: "Mahapatra, Chandrabhanu" <cmahapatra@ti.com>
Date: Tue, 20 Dec 2011 12:28:51 +0000
Subject: Re: [PATCH V2 0/2] OMAPDSS: DISPC: Peformance improvement of DISPC Scaling
Message-Id: <CAF0AtAu8bHRhKv0so49NiCbT2eyfAHn6+Rp74h+r2pK7wXqYqA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1324283602-6383-1-git-send-email-cmahapatra@ti.com>
	<1324370169.2042.2.camel@deskari>
In-Reply-To: <1324370169.2042.2.camel@deskari>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-fbdev@vger.kernel.org

On Tue, Dec 20, 2011 at 2:06 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wro=
te:
> On Mon, 2011-12-19 at 14:03 +0530, Chandrabhanu Mahapatra wrote:
>> Hi everyone,
>> the following patch set directs to improve the scaling performance of DI=
SPC
>> module which consists of two pacthes.
>>
>> The first patch is based on code of Lajos Molnar <lajos@ti.com> from And=
roid
>> Kernel, which updates the code with new set of coefficients to improve t=
he
>> scaling performance.
>>
>> The second patch is based on some very valuable suggestions by
>> Sebastien Fagard <s-fagard@ti.com> and directs to modify the clock
>> requirements for scaling to support OMAP4 and avoid clock failure issues.
>>
>> I have tested these patches on OMAP2, OMAP3 AND OMAP4. To test on 2430SDP
>> board I have created a patch to enable the display which will follow lat=
er.
>>
>> All your comments and suggestions are welcome.
>
> Thanks, this looks good. Applied to DSS master branch. There was a minor
> conflict with the Makefile, but I fixed that.
>
> Btw, when doing new versions of a patch series, it would be good to have
> a short history of the series in the introduction email, so that the
> reviewers can easily see what's new in each version.
>
> =A0Tomi
>
Thanks Tomi ! Its a good idea to including history of the series in
the introduction. I will do so in further patches to come.


--=20
Chandrabhanu Mahapatra
Texas Instruments India Pvt. Ltd.
