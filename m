Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48236130AD7
	for <linux-fbdev@vger.kernel.org>; Thu, 13 Jun 2024 06:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718258402; cv=none; b=uxmW3iea0HFhZi3TukNyhG8UQq304SlpRkau9Brf4aprgp2Vmqa/CvU/X/RxKPZXj0uc6+YwZ5uly7/uImYfqoGbVFibpdKh0ZYXVqIAdg5sC82HleT6JbhwJJP4agL3h5scCFM5yooUpzOxQZpk95CpD9NWkuk+bA91h2E0RiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718258402; c=relaxed/simple;
	bh=nWnG2dGrrgbgL9ZeXV5Mu+g2O4u2TjdcrStJDl/CUjg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=hgULZYcoPkxnOIvPmpqS01XLdBrUfp2P5MM4g0Bm1gDnZD0qFcuIGeSSCJTODUnRNJlz9WTpQnEYhfCnGk0m3Lt/EXSgXkwzMl3ctb57f4lInKdt1BzKwtbw3pk5ykcZDIvVfo9mZCOlf1EZT6F/IoKJI9L5EXJK6jTBJEnQkmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lafEoKHz; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lafEoKHz"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57c923e03caso467623a12.3
        for <linux-fbdev@vger.kernel.org>; Wed, 12 Jun 2024 23:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718258399; x=1718863199; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nWnG2dGrrgbgL9ZeXV5Mu+g2O4u2TjdcrStJDl/CUjg=;
        b=lafEoKHzSTz+UIplcSJusUiMq42xhxZFja9XQV2snf12SXsYPUXbMChS+0UBoXWysM
         dbduCnC7WNga26+1T7r5jCO6BGy/3au3Y0+9Ce7XdfIwUfJecgFFsFvXYwInJciYkdqL
         OB5lKvGD7mNHbw4cclvP/s5gHXsB/UkuXHb8rJVPTDMHfRiRslQuw8RCp7jMHWQ2O4w9
         4WUp9MZZv73MzF1YNfhi67aFAHgaWt5uKTavgusv9gmdu2Fwk4yZrqhMeJxtcDJUgApm
         d5ng82sXyWAYFwB5MV/TyFoonjE9mZx/JZgdKfdm9TQh++Ysfg+b5MfayMhzUPkIbRBG
         06Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718258399; x=1718863199;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nWnG2dGrrgbgL9ZeXV5Mu+g2O4u2TjdcrStJDl/CUjg=;
        b=LZLQOBjUszFqz9Az0ggPu/ObFMsP8w+D9x1PGoTtvWFJbmvRJyDx8BmtHvZfgQngow
         ewbwvykhiE4iXmKEq1aebRWrnuvt+awnTZoIGvzWPgTKjwEuePOEoSgaHM+8tiwhP81N
         MiHaiy8lE6dliLfbhNfb6FNDQ+4UEAL/MsyIswynJCh7LdsJ1W8P1PxdZmLLAArzbFJF
         u5RANyBWSZNlPswOTErHVPN6Sl10jYjQ00G4nj6RAVaFZeo6jYB4G3a2k/WJLyvxBGyH
         wg4138FRsiH8kfFwkquQDCfQr6CWa5cJ1uIN6AgdHywPcCCIfCCvv+6HUBVaHiR9P14a
         0xTw==
X-Forwarded-Encrypted: i=1; AJvYcCWXl+H9TAsRg2Yf0w0/eI9mBOoMU5C2O9SOT42VIxqBzR+h0ER7+MZueIJVMkMzA9qpwL8RChcXWcw2YZTIryZTF5Sr//+yTbANJVs=
X-Gm-Message-State: AOJu0YxuecsD6O/g5Mcv4wOkYU7az8oUre/1Ou9WzWjCfrD9qcPuScyQ
	PIPNPmlsFKsusT1BnWACoNn1N1sS5agvP2aeZwt84qoA7T8MzO6/QSPOo6tXQX7UORT//02VRha
	VSa5OAP4n9XfgPLeRko4CHf7varo=
X-Google-Smtp-Source: AGHT+IH0OG9qyd00LdBTv8+rRHGyUAiVUe4orkj7si7X8bi4KbJlMnt+CdWMp5EhBKtval4VvqGc7ziw1ULz88BIn+A=
X-Received: by 2002:a17:906:c454:b0:a6f:55e8:b361 with SMTP id
 a640c23a62f3a-a6f55e8e638mr50647866b.41.1718258399186; Wed, 12 Jun 2024
 22:59:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Thu, 13 Jun 2024 01:59:23 -0400
Message-ID: <CAAxE2A7qK1-b5g1RR-GJ+QTLEr_OxEr9vcZGEOkZY9yLOFLb5w@mail.gmail.com>
Subject: "firmware/sysfb: Set firmware-framebuffer parent device" breaks
 lightdm on Ubuntu 22.04 using amdgpu
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com, pjones@redhat.com, 
	deller@gmx.de, ardb@kernel.org, dri-devel <dri-devel@lists.freedesktop.org>, 
	linux-fbdev@vger.kernel.org, "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"

Hi Thomas,

Commit 9eac534db0013aff9b9124985dab114600df9081 as per the title
breaks (crashes?) lightdm (login screen) such that all I get is the
terminal. It's also reproducible with tag v6.9 where the commit is
present.

Reverting the commit fixes lightdm. A workaround is to bypass lightdm
by triggering auto-login. This is a bug report.

(For AMD folks: It's also reproducible with amd-staging-drm-next.)

Marek
