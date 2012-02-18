From: "Clark, Rob" <rob@ti.com>
Date: Sat, 18 Feb 2012 17:53:45 +0000
Subject: Re: Kernel Display and Video API Consolidation mini-summit at ELC 2012 - Notes
Message-Id: <CAO8GWqk8ETrYT7VKL2Mdis3-6iYo8rkeEJObYXTngXDH=HzjAA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201201171126.42675.laurent.pinchart@ideasonboard.com>
	<1654816.MX2JJ87BEo@avalon>
	<1775349.d0yvHiVdjB@avalon>
	<4F3EADAA.9090702@redhat.com>
In-Reply-To: <4F3EADAA.9090702@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Adam Jackson <ajax@redhat.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Tomasz Stanislawski <t.stanislaws@samsung.com>, linux-fbdev@vger.kernel.org, Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>, Pawel Osciak <pawel@osciak.com>, Magnus Damm <magnus.damm@gmail.com>, Marcus Lorentzon <marcus.lorentzon@linaro.org>, dri-devel@lists.freedesktop.org, Alexander Deucher <alexander.deucher@amd.com>, linux-media@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>

On Fri, Feb 17, 2012 at 1:42 PM, Adam Jackson <ajax@redhat.com> wrote:
> On 2/16/12 6:25 PM, Laurent Pinchart wrote:
>
>> =A0 Helper functions will be implemented in the subsystems to convert
>> between
>> =A0 that generic structure and the various subsystem-specific structures.
>
>
> I guess. =A0I don't really see a reason not to unify the structs too, but=
 then
> I don't have binary blobs to pretend to be ABI-compatible with.
>

this is just for where timing struct is exposed to userspace

BR,
-R
