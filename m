From: Jani Nikula <jani.nikula@intel.com>
Date: Fri, 29 Nov 2019 10:35:24 +0000
Subject: Re: [Intel-gfx] [PATCH v2 10/14] video: constify fb ops across all drivers
Message-Id: <87k17jkm1f.fsf@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1575022735.git.jani.nikula@intel.com>
 <c89c23a4393566c09c2372c4d69c851eb2724866.1575022735.git.jani.nikula@intel.com>
In-Reply-To: <c89c23a4393566c09c2372c4d69c851eb2724866.1575022735.git.jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, intel-gfx@lists.freedesktop.org

On Fri, 29 Nov 2019, Jani Nikula <jani.nikula@intel.com> wrote:
> Now that the fbops member of struct fb_info is const, we can start
> making the ops const as well.
>
> This does not cover all drivers; some actually modify the fbops struct,
> for example to adjust for different configurations, and others do more
> involved things that I'd rather not touch in practically obsolete
> drivers. Mostly this is the low hanging fruit where we can add "const"
> and be done with it.
>
> v2:
> - fix typo (Christophe de Dinechin)
> - use "static const" instead of "const static" in mx3fb.c
> - also constify smscufx.c
>
> Cc: linux-fbdev@vger.kernel.org
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>
> fixup to video drivers

Rebase artefact, to be removed before applying...

BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
