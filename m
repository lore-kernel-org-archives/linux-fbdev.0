From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH v2 0/3] DRM/KMS framebuffer fixes
Date: Tue, 03 Nov 2009 13:17:54 +0100
Message-ID: <4AF01F72.2030605@ladisch.de>
References: <4AEE8CDD.10600@ladisch.de> <4AEE8D6F.60209@ladisch.de> <alpine.LFD.2.00.0911021431360.30135@casper.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753440AbZKCMR4@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.0911021431360.30135@casper.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: Dave Airlie <airlied@redhat.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Eric Anholt <eric@anholt.net>, dri-devel@lists.sourceforge.net, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

James Simmons wrote:
>> Without an allocated colormap, FBIOGETCMAP fails.  This would make
>> programs restore an all-black colormap ("links -g") or fail to work
>> altogether ("mplayer -vo fbdev2").
>> 
>> --- linux-2.6/drivers/gpu/drm/i915/intel_fb.c
>> +++ linux-2.6/drivers/gpu/drm/i915/intel_fb.c
>> @@ -227,6 +227,10 @@ static int intelfb_create(struct drm_dev
>>  
>>  	fb->fbdev = info;
>>  
>> +	ret = fb_alloc_cmap(&info->cmap, 256, 0);
>> +	if (ret)
>> +		goto out_unpin;
>> +
>>  	par->intel_fb = intel_fb;
> 
> It would be better to place that code in drm_fb_helper_single_fb_probe.

Thanks, I wasn't quite able to untangle the indirections between the
four framebuffer structures.

New patch set follows.
