From: "Semwal, Sumit" <sumit.semwal@ti.com>
Date: Fri, 17 Feb 2012 11:19:35 +0000
Subject: Re: Kernel Display and Video API Consolidation mini-summit at ELC 2012 - Notes
Message-Id: <CAB2ybb_-ULCsfS48u7HQiRDLG5y-X2rmyXvHBcCRtc=m-732hQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201201171126.42675.laurent.pinchart@ideasonboard.com>
 <1654816.MX2JJ87BEo@avalon> <1775349.d0yvHiVdjB@avalon>
In-Reply-To: <1775349.d0yvHiVdjB@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>, Jesse Barker <jesse.barker@linaro.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Rob Clark <rob@ti.com>, Pawel Osciak <pawel@osciak.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Tomasz Stanislawski <t.stanislaws@samsung.com>, Magnus Damm <magnus.damm@gmail.com>, Marcus Lorentzon <marcus.lorentzon@linaro.org>, Alexander Deucher <alexander.deucher@amd.com>, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org

Hello Laurent, Everyone:


On Fri, Feb 17, 2012 at 4:55 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hello everybody,
>
> First of all, I would like to thank all the attendees for their participa=
tion
> in the mini-summit that helped make the meeting a success.
>
<snip>
> *** =A0dma-buf Implementation in V4L2 ***
>
> =A0Goal: Implement the dma-buf API in V4L2.
>
> =A0Sumit Semwal has submitted patches to implement the dma-buf importer r=
ole in
> =A0videobuf2. Tomasz Stanislawski has then submitted incremental patches =
to add
> =A0exporter role support.
>
> =A0Action points:
> =A0- Create a git branch to host all the latest patches. Sumit will provi=
de
> =A0 =A0that.
>
>
Against my Action Item: I have created the following branch at my
github (obviously, it is an RFC branch only)

tree: git://github.com/sumitsemwal/kernel-omap4.git
branch: 3.3rc3-v4l2-dmabuf-RFCv1

As the name partially suggests, it is based out of:
3.3-rc3 +
dmav6 [1] +
some minor dma-buf updates [2] +
my v4l2-as-importer RFC [3] +
Tomasz' RFC for v4l2-as-exporter (and related patches) [4]

Since Tomasz' RFC had a patch-pair which first removed and then added
drivers/media/video/videobuf2-dma-contig.c file, I 'combined' these
into one - but since the patch-pair heavily refactored the file, I am
not able to take responsibility of completeness / correctness of the
same.

[1]: http://git.infradead.org/users/kmpark/linux-samsung/shortlog/refs/head=
s/3.3-rc2-dma-v6
[2]: git://git.linaro.org/people/sumitsemwal/linux-3.x.git 'dev' branch
[3]: http://thread.gmane.org/gmane.linux.drivers.video-input-infrastructure=
/42966/focusB968
[4]: http://thread.gmane.org/gmane.linux.drivers.video-input-infrastructure=
/43793

Best regards,
~Sumit.
