From: Dave Airlie <airlied@gmail.com>
Date: Fri, 31 May 2013 03:47:26 +0000
Subject: Re: [PATCH v3 3/9] drm: Update drm_addmap and drm_mmap to use PAT WC instead of MTRRs
Message-Id: <CAPM=9tx+pdFmXnLzZKpa1VcvH_6siydZckhLVSWOM_aJAj0WUg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1368485053.git.luto@amacapital.net>
	<b1c6c2652b302431a4d4cff46ac872db8e520b6a.1368485053.git.luto@amacapital.net>
In-Reply-To: <b1c6c2652b302431a4d4cff46ac872db8e520b6a.1368485053.git.luto@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andy Lutomirski <luto@amacapital.net>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>, Jerome Glisse <j.glisse@gmail.com>, Alex Deucher <alexdeucher@gmail.com>

On Tue, May 14, 2013 at 9:58 AM, Andy Lutomirski <luto@amacapital.net> wrote:
> Previously, DRM_FRAME_BUFFER mappings, as well as DRM_REGISTERS
> mappings with DRM_WRITE_COMBINING set, resulted in an unconditional
> MTRR being added but the actual mappings being created as UC-.
>
> Now these mappings have the MTRR added only if needed, but they will
> be mapped with pgprot_writecombine.
>
> The non-WC DRM_REGISTERS case now uses pgprot_noncached instead of
> hardcoding the bit twiddling.
>
> The DRM_AGP case is unchanged for now.

Just FYI this breaks on powerpc build, I've fixed it up and pushed the
fixed version to
drm-next-staging, I'll push that to drm-next in a couple of days, once
kbuild robot hits it.

Dave.
