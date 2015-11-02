From: Pavel Machek <pavel@ucw.cz>
Date: Mon, 02 Nov 2015 07:31:33 +0000
Subject: Re: Mobility Radeon HD 4530/4570/545v: warnings
Message-Id: <20151102073133.GA12200@amd>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20151031201344.GA30459@amd>
 <563522C5.1000206@amd.com>
In-Reply-To: <563522C5.1000206@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: alexander.deucher@amd.com, linux-fbdev@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org

Hi!

One more thing: in my config, I get ton of warnings. I'm not using
modules, so everything is built-in.

Best regards,
								Pavel


In file included from drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c:24:0:
drivers/gpu/drm/amd/amdgpu/amdgpu.h:1754:12: warning: ‘amdgpu_mn_register’ defined but not used [-Wunused-function]
 static int amdgpu_mn_register(struct amdgpu_bo *bo, unsigned long addr)
            ^
drivers/gpu/drm/amd/amdgpu/amdgpu.h:1758:13: warning: ‘amdgpu_mn_unregister’ defined but not used [-Wunused-function]
 static void amdgpu_mn_unregister(struct amdgpu_bo *bo) {}
             ^
  CC      drivers/gpu/drm/amd/amdgpu/atombios_dp.o
In file included from drivers/gpu/drm/amd/amdgpu/atombios_dp.c:29:0:
drivers/gpu/drm/amd/amdgpu/amdgpu.h:1754:12: warning: ‘amdgpu_mn_register’ defined but not used [-Wunused-function]
 static int amdgpu_mn_register(struct amdgpu_bo *bo, unsigned long addr)
            ^
drivers/gpu/drm/amd/amdgpu/amdgpu.h:1758:13: warning: ‘amdgpu_mn_unregister’ defined but not used [-Wunused-function]
 static void amdgpu_mn_unregister(struct amdgpu_bo *bo) {}
             ^

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
