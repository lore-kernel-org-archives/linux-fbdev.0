From: Rob Clark <robdclark@gmail.com>
Date: Fri, 03 Jul 2015 13:33:13 +0000
Subject: Re: [RFC 1/6] drm: Add top level Kconfig option for DRM fbdev emulation
Message-Id: <CAF6AEGv0H_wSU-hU-YfmtV3VqJ_U4zFGL+WG6ha3NhfxFG-Waw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <54FFFAEE.3020301@codeaurora.org>
 <20150311151731.GJ3800@phenom.ffwll.local>
 <550282C3.10903@codeaurora.org>
 <20150313090651.GZ3800@phenom.ffwll.local>
 <55126F32.90404@codeaurora.org>
 <20150325092111.GT1349@phenom.ffwll.local>
 <CAKMK7uESo7hF1h2PbcteLOUqiubXv0c7nqR=etOp6gH8=+EDjQ@mail.gmail.com>
 <55924BA6.4050309@codeaurora.org>
 <CA+M3ks4vtDfA3rxBhEoiuZ8Tv_k15ddHRvAWP+MNgLkOMArTaw@mail.gmail.com>
 <CAKMK7uF=VY54wGEkq6r6Dt9fhSfhT8zYnsf0sPmQstDfUuRdrg@mail.gmail.com>
 <20150703123246.GA29257@ulmo.nvidia.com>
In-Reply-To: <20150703123246.GA29257@ulmo.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Thierry Reding <treding@nvidia.com>

On Fri, Jul 3, 2015 at 8:32 AM, Thierry Reding <thierry.reding@gmail.com> w=
rote:
> On Tue, Jun 30, 2015 at 11:04:45AM +0200, Daniel Vetter wrote:
>> On Tue, Jun 30, 2015 at 10:31 AM, Benjamin Gaignard
>> <benjamin.gaignard@linaro.org> wrote:
>> > I think that what have been done by Rob with module_param is also a go=
od idea:
>> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commi=
t/drivers/gpu/drm/msm/msm_drv.c?id=E90dfec78ec288d6c89a7b508a5c5d4ae8b7f934
>> >
>> > Can you mix compilation flag and module param ?
>>
>> Hm, the point of the kconfig is to not require all the legacy baggage
>> from fbdev. But I guess a module option could be added later on too.
>> bochs has it too.
>
> I think the option would primarily be useful for testing. I've often
> needed to test modesetting code without fbdev getting in the way and the
> only way to currently do that is by recompiling with legacy fbdev
> disabled. The option would allow an fbdev-enabled kernel to be used but
> disable the fbdev code if desired.

and for debugging.. when things are going wrong it's nice for the
first modeset to not happen under console_lock ;-)

BR,
-R

> Thierry
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
>
