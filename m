Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792901080;
	b=s8rcAy80ZFSyrpiUvOmLi6OXRsWSs1hPhIXTrR/Wmcln+mH/HzSCVfFrWEuxZyeU/Bbc
	 NM04+g0PIKgJyZJKkpvHqRXEYl0K85OU2LDBUhQ1FhZHGG55UCvNq+iVVjC49Fy8On6Ou
	 1IAraa1SBuDYR8Nvs8M+AiaqBNwE76sBWMoTFNAl/N1SXEFpbXabQl61HiN8KINIYwwY/
	 hdMtRzyLEnx9qBMg25aK6ZmtaG2zE7QYUZH4UzNvjZFnGS1ZQBe6/M7iZVgdymaKlOJsE
	 sQJEf6gpv7DA+A/aPSJ/jOzGYGbLx1I3Lt69OImWej8K1RCJHWKC44vdNoXHMa+jWSQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792901080;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=VKL+IlOrUm1VXsCNzHFeD+tPlKLbYMOYzxsjtjq1Vn0=;
	b=mDAGylpW+XmPlIbDxNSHQgw1GGQ4x3e6f8Ga/+l76xvohYwfyTYGPepNCVeB6zYbC9s+
	 fANEqc/t8y3UPmRvslRFOBiijgl8mSdEAuBtVnYdGSJQe+SmzE2OV9I7RIiALQKgsdoGT
	 JFN0kxZS199tR7J0EhxNyAxdW+3t2A82GseSv7o0enTJOrS8i7JYQ1nbtxoVpl7rV2P/9
	 njxW+Iq2vB1d0StJKeNqqCKJWuBui6XUscXiLvGqy5oC4Y9YoqsQlM6x3DKytLkAi0PF9
	 c3MfelTRMkGmIlJi69yrsLUvkB3PY75IM/iwRAp4t2pLfkGuFZqNuSfMbLrtfu0+5zw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=X0gz2jZ4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.52
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCD3606A31A
	for <linux-fbdev@vger.kernel.org>; Sun, 25 Oct 2026 04:04:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CCD3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=X0gz2jZ4
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-990835cec4bso1126523241.1
        for <linux-fbdev@vger.kernel.org>; Sat, 24 Oct 2026 21:04:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792901078; cv=none;
        d=google.com; s=arc-20260327;
        b=k6jNYfci62oQBuW9/YMQD5z12PISFwEQnIkuq8+BTVJhVJRHT1QUMMOqptaUGNy2j0
         AB1LdnkWEQnjBqYhqfEpWKJrlRXbdOJRCCdsO+/n0XQYGLfLZKnCsRyNX+Dqc4+zqv5w
         VtlXxpm1tmsmclD8SWMMYY6QJag1YaYSJsgoFx7slEE6B7G+EiGm09BbJWIAu0kvu8Ab
         bLnUZwkpvvf+JS2qGl1auobMMQZGej+NYAHe10PGO9lnw3ZHV7u9koMXxUj4K/ti9Pn9
         0EhxQNu+N8H1E3fPcJ7zRmnfNQUCMJhJL788KxtCZ/XOp0kQPb1S9ZCHdmVwxYT1IF8c
         XpGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VKL+IlOrUm1VXsCNzHFeD+tPlKLbYMOYzxsjtjq1Vn0=;
        fh=1fd4+t9kkW73Pj9xAggN28Pul+G8ezzjgZdZrquDeiU=;
        b=jFrYBJ6jjgKirlwbJzt3F+67TfZguHe7IwSbhnWtkkVZLEjkn/aOXR+r+xRpzy2e3s
         1nUwNmjzo18DvcGrQnQ/ibL3iQrBBwI7th3Y7Q/qKJH3kFIVT2IximaAkF8wrHRVs1Vx
         DotUOkq3+Wfqy4mcbK7UgrHXUPp6a6qLcwzd+p8WLsvm+JrsvXf8LWIl6CdEeKVD3qTT
         w4eESEEODPuOfS4TFgpZE05eO2OqB+bqmqfHhRJhKmG/MiepORvDUF5WxmFcqo5uvd8M
         qDmjBcwNaRVK1Arxcv0KoP+Sgctp1fILZUUHc8oLdTVdO8iCABVfk6Zme9b0w6/n53rW
         /j1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792901078; x=1793505878; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VKL+IlOrUm1VXsCNzHFeD+tPlKLbYMOYzxsjtjq1Vn0=;
        b=X0gz2jZ4BAEIr+bB82syNXgRCNBxdm4bDuX7peUgMgkmPjhKLLwMQBAevCKbwxgVzR
         s2OPFCVqTH1QdS2q3edGXfQhHpNixGdq/KEimhtXo3Qk6Hrt/40UGxLYgoot5uAslNuV
         F5oI12qRL3VOYDuB0v8d+Ffsnu9sEp0pxPgyvYUAqbUexUab5EDPB4cg4e9qPb7S4yFP
         YsHkzZ8Z60SNt+t5vIp380xGLFFaj8lzaFquiru7GC1xy81JU6CO1ybAl6pcmYyd9r0t
         xnjD0buXyV2GlIQ6XF5l8o06HgBkwb83eS+D5L1SAQiVO5wIpQ3vWz0VBOMaGsKPpu9I
         38Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792901078; x=1793505878;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VKL+IlOrUm1VXsCNzHFeD+tPlKLbYMOYzxsjtjq1Vn0=;
        b=W5RNTB6rS0oTxSJMihFNvIpDoiMKYtk05M0f4gp54W7GitWA9pE+0NZ9pDAAVkNrtt
         viFoKqAFQgvIaoFrduaM/xhjP8/78RymCWYnXp05BzZ0y6UPr/SmP3osybO+biZ4nmbc
         3ktyMiiaY5UJKHbSuCclFBb8jD84n0EpL9wN3ASYaAknxePm8vVtveeMeuXtv9wpz4aG
         sdn7CfTqZQap9ozc9p94eJh4hkNq9OYrqTu1Ys1yDerNS3kbYW8FMAubM3Xm0vhMCajj
         0e4/A2VIjmaP/G4QuroEBFsagwsq2Y4TyABq6x0Dxbp7G7sQu7PRCMETgAw51pMDbByR
         xLsA==
X-Forwarded-Encrypted: i=1; AKwUvByAZvZPwEgQCJYs0V20njUsIHJ9jt5nQ/L7HVQQfPopTkWg65lsTCnV2icsKZGRfrwhGxTf8yCIcd36Mw==@vger.kernel.org
X-Gm-Message-State: AFq9FYKqD5/J6/KoSNlgkO0xO+O1gUUBKlx41YQi3rTlNwNMp3F2ZTnm
	+lYweAD7tVl6zb8CE126TYVpvDxeNOGoBNDMYSo/MExWY00Zr1htQJa81EPal5vnZvyNVwYcUT7
	8We9krHf8a9aua0UUAc4rR1w+H+7fsmBWoaRu2vH2mw==
X-Gm-Gg: AYBFou2NksyK4K6GLVxNBGapRpdanj7f5xl0DNUPJhXvLs8CywIwpNM9Y2KT0El9T74
	rFXWQdWptOUCzud8GT1FCPHmRat/w7Vq23PC+lbePo5f3Ubyqbt6Xnp/qtTF1Tcc9QCH2nhVZrL
	nPuUIZd13TzdhvbBJxLgEC931wzxSQjWlh12VoeqijqU4ivfCuxt3+1yW5bGS/nNaP3qVBbYTIM
	65qERJGFvmASZcdSTZ7Q2aGVNGtyW19f4AulKd7wgDPEu5QtpZ6jgRWNkkCzOC78SyKXbeQP1LI
	PQKF6NH+5id5mUMYPhFtAc2aWH42WJBj5Ojz3yGGISiKBvlsfOjuPCslDNkzrYPzt4MpCkllRt0
	vtSqKaXFrxbCb0DNtSILMHO1KUQvJ96TikGI=
X-Received: by 2002:a05:6102:148c:b0:7a7:19aa:8a88 with SMTP id
 ada2fe7eead31-7ce5ce75811mr1182513137.35.1792901078391; Sat, 24 Oct 2026
 21:04:38 -0700 (PDT)
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024133037.160112-1-dev.adityanagar@gmail.com>
 <202610250804.hHGFSj0x-lkp@intel.com> <CAHLX7j4HHBsBZnPbP2mRMV_7t1Hwai6fLMD6sy_BDG7LnSgoCw@mail.gmail.com>
In-Reply-To: <CAHLX7j4HHBsBZnPbP2mRMV_7t1Hwai6fLMD6sy_BDG7LnSgoCw@mail.gmail.com>
From: Aditya Nagar <dev.adityanagar@gmail.com>
Date: Sun, 25 Oct 2026 09:34:27 +0530
X-Gm-Features: AclHuK_zLmaSNGQbD6tKw3EjvTfzvFJV_IV4PBzVX3aOSVcoUtF1BX--Oqer0kQ
Message-ID: <CAHLX7j4D25+obHwDtQoFNjU9Jo0MOdMFRTy9Y9fg8ayR3903bw@mail.gmail.com>
Subject: Re: [PATCH] staging: sm750fb: constify the pointer array g_fbmode
To: kernel test robot <lkp@intel.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, 
	oe-kbuild-all@lists.linux.dev, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for the report. The patch is wrong: g_fbmode[] is assigned at
runtime in lynxfb_set_fbinfo() and sm750fb_setup(), so its elements
can't be const. The checkpatch warning is a false positive here.

Please drop this patch. Sorry for the noise.

Thanks,
Aditya


On Sun, Oct 25, 2026 at 9:33=E2=80=AFAM Aditya Nagar <dev.adityanagar@gmail=
.com> wrote:
>
> Hi,
>
> Thanks for the report. The patch is wrong: g_fbmode[] is assigned at runt=
ime in lynxfb_set_fbinfo() and sm750fb_setup(), so its elements can't be co=
nst. The checkpatch warning is a false positive here.
>
> Please drop this patch. Sorry for the noise.
>
> Thanks,
> Aditya
>
> On Sun, Oct 25, 2026 at 5:48=E2=80=AFAM kernel test robot <lkp@intel.com>=
 wrote:
>>
>> Hi Aditya,
>>
>> kernel test robot noticed the following build errors:
>>
>> [auto build test ERROR on staging/staging-linus]
>> [also build test ERROR on linus/master v7.3]
>> [cannot apply to staging/staging-testing staging/staging-next next-20261=
023]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/Aditya-Nagar/stag=
ing-sm750fb-constify-the-pointer-array-g_fbmode/20261024-190037
>> base:   staging/staging-linus
>> patch link:    https://lore.kernel.org/r/20261024133037.160112-1-dev.adi=
tyanagar%40gmail.com
>> patch subject: [PATCH] staging: sm750fb: constify the pointer array g_fb=
mode
>> config: parisc-randconfig-1000-20261025 (https://download.01.org/0day-ci=
/archive/20261025/202610250804.hHGFSj0x-lkp@intel.com/config)
>> compiler: hppa-linux-gcc (GCC) 10.5.0
>> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arch=
ive/20261025/202610250804.hHGFSj0x-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new ver=
sion of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202610250804.hHGFSj0x-lk=
p@intel.com/
>>
>> All errors (new ones prefixed by >>):
>>
>>    drivers/staging/sm750fb/sm750.c: In function 'lynxfb_set_fbinfo':
>> >> drivers/staging/sm750fb/sm750.c:762:19: error: assignment of read-onl=
y location 'g_fbmode[index]'
>>      762 |   g_fbmode[index] =3D g_def_fbmode;
>>          |                   ^
>>    drivers/staging/sm750fb/sm750.c:764:20: error: assignment of read-onl=
y location 'g_fbmode[index]'
>>      764 |    g_fbmode[index] =3D g_fbmode[0];
>>          |                    ^
>>    drivers/staging/sm750fb/sm750.c: In function 'sm750fb_setup':
>> >> drivers/staging/sm750fb/sm750.c:872:17: error: assignment of read-onl=
y location 'g_fbmode[0]'
>>      872 |     g_fbmode[0] =3D opt;
>>          |                 ^
>>    drivers/staging/sm750fb/sm750.c:876:17: error: assignment of read-onl=
y location 'g_fbmode[1]'
>>      876 |     g_fbmode[1] =3D opt;
>>          |                 ^
>>
>>
>> vim +762 drivers/staging/sm750fb/sm750.c
>>
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  696
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  697  static int lynxfb_s=
et_fbinfo(struct fb_info *info, int index)
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  698  {
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  699     int i;
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  700     struct lynxfb_pa=
r *par;
>> e359b6a863e19f Mike Rapoport        2015-10-26  701     struct sm750_dev=
 *sm750_dev;
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  702     struct lynxfb_cr=
tc *crtc;
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  703     struct lynxfb_ou=
tput *output;
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  704     struct fb_var_sc=
reeninfo *var;
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  705     struct fb_fix_sc=
reeninfo *fix;
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  706
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  707     const struct fb_=
videomode *pdb[] =3D {
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  708             lynx750_=
ext, NULL, vesa_modes,
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  709     };
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  710     int cdb[] =3D {A=
RRAY_SIZE(lynx750_ext), 0, VESA_MODEDB_SIZE};
>> d0856045f0e9fc Hungyu Lin           2026-04-01  711     static const cha=
r * const fix_id[2] =3D {
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  712             "sm750_f=
b1", "sm750_fb2",
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  713     };
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  714
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  715     int ret, line_le=
ngth;
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  716
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  717     ret =3D 0;
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  718     par =3D (struct =
lynxfb_par *)info->par;
>> e359b6a863e19f Mike Rapoport        2015-10-26  719     sm750_dev =3D pa=
r->dev;
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  720     crtc =3D &par->c=
rtc;
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  721     output =3D &par-=
>output;
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  722     var =3D &info->v=
ar;
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  723     fix =3D &info->f=
ix;
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  724
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  725     /* set index */
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  726     par->index =3D i=
ndex;
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  727     output->channel =
=3D &crtc->channel;
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  728     sm750fb_set_drv(=
par);
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  729
>> d11ac7cbcc266c Sudip Mukherjee      2015-08-07  730     /*
>> d11ac7cbcc266c Sudip Mukherjee      2015-08-07  731      * set current c=
ursor variable and proc pointer,
>> d11ac7cbcc266c Sudip Mukherjee      2015-08-07  732      * must be set a=
fter crtc member initialized
>> d11ac7cbcc266c Sudip Mukherjee      2015-08-07  733      */
>> fdc234d85210d9 Benjamin Philip      2021-07-28  734     crtc->cursor.off=
set =3D crtc->o_screen + crtc->vidmem_size - 1024;
>> 1be54c03f7519c Jad Keskes           2026-06-19  735     crtc->cursor.mmi=
o =3D sm750_dev->mmio +
>> e359b6a863e19f Mike Rapoport        2015-10-26  736             0x800f0 =
+ (int)crtc->channel * 0x140;
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  737
>> cd33da26036ea5 Christopher Carbone  2022-08-23  738     crtc->cursor.max=
_h =3D 64;
>> cd33da26036ea5 Christopher Carbone  2022-08-23  739     crtc->cursor.max=
_w =3D 64;
>> 39f9137268ee3d Benjamin Philip      2021-07-26  740     crtc->cursor.siz=
e =3D crtc->cursor.max_h * crtc->cursor.max_w * 2 / 8;
>> f50b4602fea62f Jennifer Guo         2026-05-09  741     crtc->cursor.vst=
art =3D sm750_dev->vmem + crtc->cursor.offset;
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  742
>> 3de08a2d14ff8c Lorenzo Stoakes      2015-03-20  743     memset_io(crtc->=
cursor.vstart, 0, crtc->cursor.size);
>> f7c8a046577e09 Thomas Zimmermann    2023-11-27  744     if (!g_hwcursor)
>> 52d0744d751d8f Arnd Bergmann        2016-11-09  745             sm750_hw=
_cursor_disable(&crtc->cursor);
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  746
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  747     /* set info->fbo=
ps, must be set before fb_find_mode */
>> e359b6a863e19f Mike Rapoport        2015-10-26  748     if (!sm750_dev->=
accel_off) {
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  749             /* use 2=
d acceleration */
>> f7c8a046577e09 Thomas Zimmermann    2023-11-27  750             if (!g_h=
wcursor)
>> f7c8a046577e09 Thomas Zimmermann    2023-11-27  751                     =
info->fbops =3D &lynxfb_ops_accel;
>> f7c8a046577e09 Thomas Zimmermann    2023-11-27  752             else
>> f7c8a046577e09 Thomas Zimmermann    2023-11-27  753                     =
info->fbops =3D &lynxfb_ops_accel_with_cursor;
>> f7c8a046577e09 Thomas Zimmermann    2023-11-27  754     } else {
>> f7c8a046577e09 Thomas Zimmermann    2023-11-27  755             if (!g_h=
wcursor)
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  756                     =
info->fbops =3D &lynxfb_ops;
>> f7c8a046577e09 Thomas Zimmermann    2023-11-27  757             else
>> f7c8a046577e09 Thomas Zimmermann    2023-11-27  758                     =
info->fbops =3D &lynxfb_ops_with_cursor;
>> f7c8a046577e09 Thomas Zimmermann    2023-11-27  759     }
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  760
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  761     if (!g_fbmode[in=
dex]) {
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03 @762             g_fbmode=
[index] =3D g_def_fbmode;
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  763             if (inde=
x)
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  764                     =
g_fbmode[index] =3D g_fbmode[0];
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  765     }
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  766
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  767     for (i =3D 0; i =
< 3; i++) {
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  768             ret =3D =
fb_find_mode(var, info, g_fbmode[index],
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  769                     =
           pdb[i], cdb[i], NULL, 8);
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  770
>> db7fb3588ab492 Artem Lytkin         2026-02-23  771             if (ret =
=3D=3D 1 || ret =3D=3D 2)
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  772                     =
break;
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  773     }
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  774
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  775     /* set par */
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  776     par->info =3D in=
fo;
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  777
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  778     /* set info */
>> e3a3f9f5123683 Mike Rapoport        2015-10-26  779     line_length =3D =
ALIGN((var->xres_virtual * var->bits_per_pixel / 8),
>> e3a3f9f5123683 Mike Rapoport        2015-10-26  780                     =
    crtc->line_pad);
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  781
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  782     info->pseudo_pal=
ette =3D &par->pseudo_palette[0];
>> cc59bde1c920ab Benjamin Philip      2021-07-28  783     info->screen_bas=
e =3D crtc->v_screen;
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  784     info->screen_siz=
e =3D line_length * var->yres_virtual;
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  785
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  786     /* set info->fix=
 */
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  787     fix->type =3D FB=
_TYPE_PACKED_PIXELS;
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  788     fix->type_aux =
=3D 0;
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  789     fix->xpanstep =
=3D crtc->xpanstep;
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  790     fix->ypanstep =
=3D crtc->ypanstep;
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  791     fix->ywrapstep =
=3D crtc->ywrapstep;
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  792     fix->accel =3D F=
B_ACCEL_SMI;
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  793
>> 8c475735085a7d Tim Wassink          2025-12-21  794     strscpy(fix->id,=
 fix_id[index], sizeof(fix->id));
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  795
>> fdc234d85210d9 Benjamin Philip      2021-07-28  796     fix->smem_start =
=3D crtc->o_screen + sm750_dev->vidmem_start;
>> d11ac7cbcc266c Sudip Mukherjee      2015-08-07  797     /*
>> d11ac7cbcc266c Sudip Mukherjee      2015-08-07  798      * according to =
mmap experiment from user space application,
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  799      * fix->mmio_len=
 should not larger than virtual size
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  800      * (xres_virtual=
 x yres_virtual x ByPP)
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  801      * Below line ma=
ybe buggy when user mmap fb dev node and write
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  802      * data into the=
 bound over virtual size
>> d11ac7cbcc266c Sudip Mukherjee      2015-08-07  803      */
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  804     fix->smem_len =
=3D crtc->vidmem_size;
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  805     info->screen_siz=
e =3D fix->smem_len;
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  806     fix->line_length=
 =3D line_length;
>> e359b6a863e19f Mike Rapoport        2015-10-26  807     fix->mmio_start =
=3D sm750_dev->vidreg_start;
>> e359b6a863e19f Mike Rapoport        2015-10-26  808     fix->mmio_len =
=3D sm750_dev->vidreg_size;
>> b610e1193a917f Matej Dujava         2020-04-30  809
>> b610e1193a917f Matej Dujava         2020-04-30  810     lynxfb_set_visua=
l_mode(info);
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  811
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  812     /* set var */
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  813     var->activate =
=3D FB_ACTIVATE_NOW;
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  814     var->accel_flags=
 =3D 0;
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  815     var->vmode =3D F=
B_VMODE_NONINTERLACED;
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  816
>> 61c507cf652da1 Michel von Czettritz 2015-03-26  817     ret =3D fb_alloc=
_cmap(&info->cmap, 256, 0);
>> 61c507cf652da1 Michel von Czettritz 2015-03-26  818     if (ret < 0) {
>> fbab250eb51d6d Artem Lytkin         2026-02-07  819             dev_err(=
info->device, "Could not allocate memory for cmap.\n");
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  820             goto exi=
t;
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  821     }
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  822
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  823  exit:
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  824     lynxfb_ops_check=
_var(var, info);
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  825     return ret;
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  826  }
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  827
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  828  /* chip specific g_=
option configuration routine */
>> 700591a9adc8b1 Mike Rapoport        2015-10-26  829  static void sm750fb=
_setup(struct sm750_dev *sm750_dev, char *src)
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  830  {
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  831     char *opt;
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  832     int swap;
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  833
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  834     swap =3D 0;
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  835
>> 523200db5cb01f Hungyu Lin           2026-05-30  836     sm750_dev->init_=
parm.chip_clock =3D 0;
>> 523200db5cb01f Hungyu Lin           2026-05-30  837     sm750_dev->init_=
parm.mem_clock =3D 0;
>> 523200db5cb01f Hungyu Lin           2026-05-30  838     sm750_dev->init_=
parm.master_clock =3D 0;
>> 45a337c12624fc Jennifer Guo         2026-05-09  839     sm750_dev->init_=
parm.power_mode =3D 0;
>> 45a337c12624fc Jennifer Guo         2026-05-09  840     sm750_dev->init_=
parm.reset_memory =3D 1;
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  841
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  842     /* defaultly tur=
n g_hwcursor on for both view */
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  843     g_hwcursor =3D 3=
;
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  844
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  845     if (!src || !*sr=
c) {
>> c56de0967a658c Elise Lennion        2016-10-31  846             dev_warn=
(&sm750_dev->pdev->dev, "no specific g_option.\n");
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  847             goto NO_=
PARAM;
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  848     }
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  849
>> 0fa96e39279988 Sudip Mukherjee      2015-03-10  850     while ((opt =3D =
strsep(&src, ":")) !=3D NULL && *opt !=3D 0) {
>> c56de0967a658c Elise Lennion        2016-10-31  851             dev_info=
(&sm750_dev->pdev->dev, "opt=3D%s\n", opt);
>> c56de0967a658c Elise Lennion        2016-10-31  852             dev_info=
(&sm750_dev->pdev->dev, "src=3D%s\n", src);
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  853
>> 144634a6b42146 Katie Dunne          2017-02-19  854             if (!str=
ncmp(opt, "swap", strlen("swap"))) {
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  855                     =
swap =3D 1;
>> 144634a6b42146 Katie Dunne          2017-02-19  856             } else i=
f (!strncmp(opt, "nocrt", strlen("nocrt"))) {
>> 1757d106a9ce8c Mike Rapoport        2015-10-26  857                     =
sm750_dev->nocrt =3D 1;
>> 144634a6b42146 Katie Dunne          2017-02-19  858             } else i=
f (!strncmp(opt, "36bit", strlen("36bit"))) {
>> 94c938a0c15863 Shubham Chakraborty  2026-04-07  859                     =
sm750_dev->pnltype =3D SM750_DOUBLE_TFT;
>> 144634a6b42146 Katie Dunne          2017-02-19  860             } else i=
f (!strncmp(opt, "18bit", strlen("18bit"))) {
>> 94c938a0c15863 Shubham Chakraborty  2026-04-07  861                     =
sm750_dev->pnltype =3D SM750_DUAL_TFT;
>> 144634a6b42146 Katie Dunne          2017-02-19  862             } else i=
f (!strncmp(opt, "24bit", strlen("24bit"))) {
>> 94c938a0c15863 Shubham Chakraborty  2026-04-07  863                     =
sm750_dev->pnltype =3D SM750_24TFT;
>> 144634a6b42146 Katie Dunne          2017-02-19  864             } else i=
f (!strncmp(opt, "nohwc0", strlen("nohwc0"))) {
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  865                     =
g_hwcursor &=3D ~0x1;
>> 144634a6b42146 Katie Dunne          2017-02-19  866             } else i=
f (!strncmp(opt, "nohwc1", strlen("nohwc1"))) {
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  867                     =
g_hwcursor &=3D ~0x2;
>> 144634a6b42146 Katie Dunne          2017-02-19  868             } else i=
f (!strncmp(opt, "nohwc", strlen("nohwc"))) {
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  869                     =
g_hwcursor =3D 0;
>> 144634a6b42146 Katie Dunne          2017-02-19  870             } else {
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  871                     =
if (!g_fbmode[0]) {
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03 @872                     =
        g_fbmode[0] =3D opt;
>> cee9ba1c30d051 Abdul Rauf           2017-01-08  873                     =
        dev_info(&sm750_dev->pdev->dev,
>> cee9ba1c30d051 Abdul Rauf           2017-01-08  874                     =
                 "find fbmode0 : %s\n", g_fbmode[0]);
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  875                     =
} else if (!g_fbmode[1]) {
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  876                     =
        g_fbmode[1] =3D opt;
>> cee9ba1c30d051 Abdul Rauf           2017-01-08  877                     =
        dev_info(&sm750_dev->pdev->dev,
>> cee9ba1c30d051 Abdul Rauf           2017-01-08  878                     =
                 "find fbmode1 : %s\n", g_fbmode[1]);
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  879                     =
} else {
>> c56de0967a658c Elise Lennion        2016-10-31  880                     =
        dev_warn(&sm750_dev->pdev->dev, "How many view you wann set?\n");
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  881                     =
}
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  882             }
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  883     }
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  884
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  885  NO_PARAM:
>> e359b6a863e19f Mike Rapoport        2015-10-26  886     if (sm750_dev->r=
evid !=3D SM750LE_REVISION_ID) {
>> d352778979d2ee Ahmet Sezgin Duran   2026-05-21  887             if (g_du=
alview) {
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  888                     =
if (swap)
>> 1757d106a9ce8c Mike Rapoport        2015-10-26  889                     =
        sm750_dev->dataflow =3D sm750_dual_swap;
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  890                     =
else
>> 1757d106a9ce8c Mike Rapoport        2015-10-26  891                     =
        sm750_dev->dataflow =3D sm750_dual_normal;
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  892             } else {
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  893                     =
if (swap)
>> 1757d106a9ce8c Mike Rapoport        2015-10-26  894                     =
        sm750_dev->dataflow =3D sm750_simul_sec;
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  895                     =
else
>> 1757d106a9ce8c Mike Rapoport        2015-10-26  896                     =
        sm750_dev->dataflow =3D sm750_simul_pri;
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  897             }
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  898     } else {
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  899             /* SM750=
LE only have one crt channel */
>> 1757d106a9ce8c Mike Rapoport        2015-10-26  900             sm750_de=
v->dataflow =3D sm750_simul_sec;
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  901             /* sm750=
le do not have complex attributes */
>> 1757d106a9ce8c Mike Rapoport        2015-10-26  902             sm750_de=
v->nocrt =3D 0;
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  903     }
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  904  }
>> 81dee67e215b23 Sudip Mukherjee      2015-03-03  905
>>
>> --
>> 0-DAY CI Kernel Test Service
>> https://github.com/intel/lkp-tests/wiki
