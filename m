Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PkS2bZ9X"
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CE4E3
	for <linux-fbdev@vger.kernel.org>; Sun, 26 Nov 2023 08:30:03 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-5079f6efd64so4659495e87.2
        for <linux-fbdev@vger.kernel.org>; Sun, 26 Nov 2023 08:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1701016201; x=1701621001; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sSJ+yeqxuvutnkpSkcqAmI5LAVDWcSBce0PQad7lFBQ=;
        b=PkS2bZ9XIf1gB9rDAW2NcW53LskZxG24TPyKzs+aqE5rJ1Htr32CvpMZwO1Gp+Gmo3
         QWnDQdp+IcG1bRebFUlQHhkkpMBcxSK/5nWgZUp3zjQI/Wbf0dHcTTDe+M+z6tCp3aef
         A99jWaJwCfQUd6S/lxAcNbzjzRlNA40tVt160=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701016201; x=1701621001;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sSJ+yeqxuvutnkpSkcqAmI5LAVDWcSBce0PQad7lFBQ=;
        b=oF9mJa+ACkvnAn5w47fQUO9VOUqc4oPp77JAiRTgcDEa5wwhRnwUr36OraxuwDq0qy
         F1mdX8nfPU4pfH5GMqasmtouXgxX/D5mVXSln+ba1hWHpVhN50L3SO48jBxDbsgLDEAf
         AM+KDkbHAcepGpBVRJHar/HBmXbnvhzy4M1i8y3Aj9VJAnw1XTZ+AwukBLhc5N0lr+B7
         NhGiXdDnNhVic+syKaU7DrHUYiYiVcLqrqsrXiiSkbEMtOE1ddW+/fMgumlrcjK5BDJK
         DKSxD+HLRD1YIIrdIIGEsLSax4a+wh9FlpQAJ60B5Gts+D29JeZjwqBqEUslQMWQhdYH
         imoA==
X-Gm-Message-State: AOJu0Yx2cKRNCm55od+0c3KDC7c+OnSP3+SCdLwaeM+B/F626CdVAnOS
	wCRuoLZWyLZWitkZ1VGyo0nRUKgTuLD5mlHpF1K4PiMc
X-Google-Smtp-Source: AGHT+IHybEgoCaoyJ7cE6pRWmxDTqpnm+yjwqEDh8HrAFkoeTQ6C/fnuxTkbgi1FIywP2+dY9mkFNg==
X-Received: by 2002:a2e:8086:0:b0:2c8:721c:6912 with SMTP id i6-20020a2e8086000000b002c8721c6912mr5668070ljg.37.1701016201469;
        Sun, 26 Nov 2023 08:30:01 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id a21-20020a2e88d5000000b002c882f503basm1042453ljk.13.2023.11.26.08.30.00
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Nov 2023 08:30:00 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-507a98517f3so4694088e87.0
        for <linux-fbdev@vger.kernel.org>; Sun, 26 Nov 2023 08:30:00 -0800 (PST)
X-Received: by 2002:a19:5e03:0:b0:509:dec:9f3c with SMTP id
 s3-20020a195e03000000b005090dec9f3cmr4999914lfb.50.1701016200246; Sun, 26 Nov
 2023 08:30:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZWLsgGku7j_7_eVE@ls3530>
In-Reply-To: <ZWLsgGku7j_7_eVE@ls3530>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 26 Nov 2023 08:29:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiR5yLK6-n5p=F97unF1bf3DuPdGcv0MZcO51aiik4T0w@mail.gmail.com>
Message-ID: <CAHk-=wiR5yLK6-n5p=F97unF1bf3DuPdGcv0MZcO51aiik4T0w@mail.gmail.com>
Subject: Re: [GIT PULL] fbdev fixes and updates for v6.7-rc3
To: Helge Deller <deller@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 25 Nov 2023 at 22:58, Helge Deller <deller@gmx.de> wrote:
>
> please pull some small fbdev fixes for 6.7-rc3.

These all seem to be pure cleanups, not bug fixes.

Please resend during the merge window.

            Linus
