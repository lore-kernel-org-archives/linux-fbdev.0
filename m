From: Daniel Vetter <daniel@ffwll.ch>
Date: Tue, 30 Jun 2015 09:04:45 +0000
Subject: Re: [RFC 1/6] drm: Add top level Kconfig option for DRM fbdev emulation
Message-Id: <CAKMK7uF=VY54wGEkq6r6Dt9fhSfhT8zYnsf0sPmQstDfUuRdrg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150310094756.GE3800@phenom.ffwll.local>
 <54FEBEF1.5000103@codeaurora.org>
 <20150310100547.GG3800@phenom.ffwll.local>
 <54FEC5F1.90208@codeaurora.org>
 <20150310121702.GO3800@phenom.ffwll.local>
 <54FFFAEE.3020301@codeaurora.org>
 <20150311151731.GJ3800@phenom.ffwll.local>
 <550282C3.10903@codeaurora.org>
 <20150313090651.GZ3800@phenom.ffwll.local>
 <55126F32.90404@codeaurora.org>
 <20150325092111.GT1349@phenom.ffwll.local>
 <CAKMK7uESo7hF1h2PbcteLOUqiubXv0c7nqR=etOp6gH8=+EDjQ@mail.gmail.com>
 <55924BA6.4050309@codeaurora.org>
 <CA+M3ks4vtDfA3rxBhEoiuZ8Tv_k15ddHRvAWP+MNgLkOMArTaw@mail.gmail.com>
In-Reply-To: <CA+M3ks4vtDfA3rxBhEoiuZ8Tv_k15ddHRvAWP+MNgLkOMArTaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Thierry Reding <treding@nvidia.com>

On Tue, Jun 30, 2015 at 10:31 AM, Benjamin Gaignard
<benjamin.gaignard@linaro.org> wrote:
> I think that what have been done by Rob with module_param is also a good =
idea:
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/d=
rivers/gpu/drm/msm/msm_drv.c?id=E90dfec78ec288d6c89a7b508a5c5d4ae8b7f934
>
> Can you mix compilation flag and module param ?

Hm, the point of the kconfig is to not require all the legacy baggage
from fbdev. But I guess a module option could be added later on too.
bochs has it too.
-Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
