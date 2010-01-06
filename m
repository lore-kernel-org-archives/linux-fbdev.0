From: Miles Lane <miles.lane@gmail.com>
Date: Wed, 06 Jan 2010 18:06:46 +0000
Subject: Re: 2.6.33-rc3 -- Intel 945GME (inteldrmfb) -- Two Tux images
Message-Id: <a44ae5cd1001061006i63579096me4d598b06cc358f9@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <a44ae5cd1001060916s4db1d94fsb7e012ab80ce6add@mail.gmail.com>
	 <20100106185913.39003329@neptune.home>
In-Reply-To: <20100106185913.39003329@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: LKML <linux-kernel@vger.kernel.org>, David Airlie <airlied@linux.ie>, Sylvain Meyer <sylvain.meyer@worldonline.fr>, linux-fbdev@vger.kernel.org

On Wed, Jan 6, 2010 at 12:59 PM, Bruno Pr=E9mont
<bonbons@linux-vserver.org> wrote:
> On Wed, 06 January 2010 Miles Lane <miles.lane@gmail.com> wrote:
>> For a long time I have gotten two pictures of Tux showing up when I
>> include the Tux display option in my custom kernel builds. =A0I don't
>> know how many kernel revisions ago it was when I started noticing
>> this. =A0It seems like it might have been early in the 2.6 series
>> kernels.
>
> Unless your system has exactly one CPU without hyperthreading and with
> exactly one core this is the correct bahavior, one tux per logical CPU.
>
> If you just want a single tux you can run your kernel on a system with
> only one logical CPU, boot it with maxcpus=3D1 or rebuild it with
> CONFIG_SMP=3Dn... though in those case you will not be able to benefit
> from all of your CPU's resources..
>
> Bruno

Oh!  Well, that explains it.  That is truly weird functionality.  Is
Tux a de facto
CPU presence indicator?  It doesn't make any sense to me, if so.

         Miles
