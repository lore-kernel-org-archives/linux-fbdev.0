Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNi2xsaV"
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A42D1
	for <linux-fbdev@vger.kernel.org>; Tue, 21 Nov 2023 15:45:20 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5cc5adfa464so1400737b3.2
        for <linux-fbdev@vger.kernel.org>; Tue, 21 Nov 2023 15:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700610320; x=1701215120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55K9D/0MaAgBoqzbzMgJvDDB+4XxRw/Ra3ccE8iLF8s=;
        b=MNi2xsaVLTRVfG/2SzeOsHhr7CusFhB4nzQmZD2AxhCitrqzGgjrZoUPVLN949LHlK
         spZEIdpS7pafiwra3Gu9JuyS14edyQCLnUs/SPQw1QH+ovRkzORJ+pSmnv4skK6cNxno
         czr6GlU0GO9aOu/9cc929p9gG6Yve/nkBRoTnvLfO11Vz4NKvdIAKXjn/yQPf2E9o8Ec
         7IHarmc08YtkWDgxD1pMGjT/lfTU9Veqq4JZrJhgeNrrh31PwlfeDPjTHsxD8SGYOgAG
         BZ79BLHh6r3wRNx8YBak5PS+Tm7cIDjl5/DGepScJzzq+dQHfIXpi7A1PFkmJXbAKQCR
         NYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700610320; x=1701215120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55K9D/0MaAgBoqzbzMgJvDDB+4XxRw/Ra3ccE8iLF8s=;
        b=sSljir2xmAeY+IymrHMc0g/25mfFR50bhhd5RMrI1AePOutSlovr70ehk77+Qzl+g4
         OnxzoemHSC45nZTtbuKXOpFwOyI8og9RgoPkioyQJP55IMkvBGUI9DP+FuOEUcVwaBSI
         KVPVnEXIDzrgfUgoa3k/f5k+ZvCkiYfDLor0lnuZIPGqwK6DNj2Ek0dFQi2+6VWKTCY0
         8dxseARJ9/pkYYfuuf6CYgyBJpCEr++mTBK5W3dJCNFnCyE1/BzW2xo+VWmI51u7s6+b
         Fgm0b4A1lPE5JIPfhpf/D8ihkvhybzcXG9uYzaCPSrHp1O0G6PvHxmddUFqtQrWL3sEY
         GFjA==
X-Gm-Message-State: AOJu0Yx24lqUhOeIsU3wV5Yc+BvYFANx/U0TxdGyN05vWWdSwHhmEXfb
	T3OSO7bKTJNLTElp1opfZVjr0aKhZ/92c7nPvn0=
X-Google-Smtp-Source: AGHT+IExOIvrkdEeHN5EO51l15UvLMRCLWuz9q+Qe0ufPwB8PWVqs/YBcBB6FL/ACBb+l2u1y5fH+9hzr8+d9eug8TM=
X-Received: by 2002:a81:7206:0:b0:5c1:4f00:6472 with SMTP id
 n6-20020a817206000000b005c14f006472mr461427ywc.49.1700610319892; Tue, 21 Nov
 2023 15:45:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115102954.7102-1-tzimmermann@suse.de> <20231115102954.7102-9-tzimmermann@suse.de>
In-Reply-To: <20231115102954.7102-9-tzimmermann@suse.de>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 22 Nov 2023 00:45:08 +0100
Message-ID: <CANiq72kD=zw5e_hq17zQ_3hzgZFbup7vOvvYWtJ_J22wyAbSNA@mail.gmail.com>
Subject: Re: [PATCH 08/32] auxdisplay/cfag12864bfb: Initialize fb_ops with
 fbdev macros
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: deller@gmx.de, javierm@redhat.com, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 11:30=E2=80=AFAM Thomas Zimmermann <tzimmermann@sus=
e.de> wrote:
>
> Initialize the instance of struct fb_ops with fbdev initializer
> macros for framebuffers in virtual address space. Set the read/write,
> draw and mmap callbacks to the correct implementation and avoid
> implicit defaults. Also select the necessary helpers in Kconfig.
>
> Fbdev drivers sometimes rely on the callbacks being NULL for a
> default I/O-memory-based implementation to be invoked; hence
> requiring the I/O helpers to be built in any case. Setting all
> callbacks in all drivers explicitly will allow to make the I/O
> helpers optional. This benefits systems that do not use these
> functions.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Miguel Ojeda <ojeda@kernel.org>

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
