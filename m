Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1164A33938A
	for <linux-fbdev@vger.kernel.org>; Sun, 16 Aug 2026 18:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786905431; cv=none; b=fuMhQ1R4suCgFcYo5lNu5oxha/uWdCiSzPNpFCeN/Oh5WYgaueY85Hbw5jv0KIXK2189jBfP0f+AYwxFU12KaoN5b6hCoZgPF6lzXBqTSqs9cDBpZI07c3o+fxFS8ZTI+vy9bdRyS2B1gQSUF4g5I78USVYr/G9LNYVqOUieBEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786905431; c=relaxed/simple;
	bh=N7HLf6d8Nz/syMV5s4Yf1rLjD0Nzt2vlpMLy8MmIWxg=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=QPv//XELlGdZFaCOYH30Pq+SsXhIUEfw2UXa+8dalRlYPTllY+7NhV9h/EEOK1AZ1HDRW+p+2+wfafggRKFXBfCuHzWk5q4WWwLtMUSiI7rgUACSn2gypZWAmfvQJ/agf2RqBU4xw29uCsgbCJKdoV+RgD/QbB6TUPbo6K1lLyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k25WEdQs; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k25WEdQs"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cbb8b54fcf8so2433396a12.0
        for <linux-fbdev@vger.kernel.org>; Sun, 16 Aug 2026 11:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786905429; x=1787510229; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version
         :user-agent:date:message-id:from:cc:references:to:subject:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Z4mIpJZjhlFuJPRbLBdNZD1k6jhDvLqRCr4L0uQaP6Y=;
        b=k25WEdQskIByKwzICRyDi3yy9v30r/WGecjJuxCCyYjoKdvwAL6uX4+QPyhdpearbX
         YndMWwqQm7d7dgwdxTlDFz4Q48C+0lGcy7F/nJCVallq1dAzyqc5XjSlcf9729JGBpEa
         xn2ZpC4q5hMKfLxz0o5zFwIcuYxhiC16m3Ke377oXp5bfFmutVg5OEQom7mr1EiG7wQv
         mTViN668iWKteJIbDST/WS1Js0bebS8yQKE7MXBccv9EQDq0GBGwwYf3O1uWrbGpf5jB
         lBnNfkWu3i+RMGSdeQi3bPAPH8GO75l40x8z5ANbYIIcK4XSMKG86UaFZLkmCk9nb2gO
         a/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786905429; x=1787510229;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version
         :user-agent:date:message-id:from:cc:references:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z4mIpJZjhlFuJPRbLBdNZD1k6jhDvLqRCr4L0uQaP6Y=;
        b=hwEmIAAtcwtn3ZxyzFuXD4N5kOFxWkpnNXJt4bCPUXnkniy7sX2iKY5tMuL83ntkb5
         si7eDXZ/H3+UYbfXy6xTx69r9OYd441g/ZRG5h2+yg0HqFmelmqOAJ724oTtu5eJ7nng
         xNB9Bxr3lqM4YqP/pIurYUxuTntV08ndw1JkhSJfgznT1+S2zBj9KWmWbKoIYvVU88kx
         v38dfzTfWQeuXPou6GnEqe0VkXHtmkSQn8UeRYFOnJn+3ZNbMDDrnY2m+xsTk6CGOzQ6
         +MXaddwFLZHaaaiGAr/S1KFDsAswWqJNMLE9pHlojvhCgLqOUAtOYntJXPtQ5HRW4Kts
         MEtA==
X-Forwarded-Encrypted: i=1; AHgh+RrZ6uT7g7TrRv4GrEEC+/Bqjkj101ozaPZryuHImJiaIdEKS4pEx//gvP4fzyPBfB8mnIVujhv3zbCZ+w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxut1YW6Vs2rZj5549Kg1CLFnHqHCZ32jUthQTt5ZV25WxqpA5i
	yMo1BPBsL2jM6Pu4dSVY9vCxC+VoUj9loefIfQfBjef3uWW7tgv2pziSKpyYYg==
X-Gm-Gg: AR+sD12Vty//8uAPkVzkK/RBGxenRFh1Irb7bm6JMZuvjisEX+SiC96cdV1/RSwteLZ
	IPpxcLj1jKkEz+bQ7g9SY/SGx3BlS2MxEPcRlU/kT4lBa9SCH3+bKlTAH0Gk3ShAAo1kXLt3GQV
	a+7vb3bLoitAnuElOXv++IUhCVts5Ke6qKcZg7jqbES8cBvbdVE8e+PZmdkPXvsMdoNOtHUTCg0
	a+yolZ98KujBcE9ocTGeT7H2mMqgopFi9CbO6GrU+alvXtp/KyCu+8gD0uNabmg0qgcmg6i25V/
	SxUZPuxrSNKtmQH7oXc0YOyUvht0rzw5e/2F0lYPpnVAVlcx5SURNxRcBKV5a5vSKemEbNsXUTD
	9gVf9RDXS5923HgRcNbtvw9yJmVoM1PQn5zRJFCGmZ+UoHh1UPwJo2fjk2PEg4AT49A9mWGuMap
	dYJOqJfeKXcVBZdtsWofOtC6ZSnzS0qk2d1hSlfdWc8hnGY3jHoSmMNm7mZqk8gHz288Z2eML1A
	WFJKS/5yLXqRz7D2nYU9oGvFxhdXdUDdBE=
X-Received: by 2002:a05:6a20:7345:b0:3c3:b57b:6291 with SMTP id adf61e73a8af0-3cc71d1e819mr20982093637.18.1786905429167;
        Sun, 16 Aug 2026 11:37:09 -0700 (PDT)
Received: from [10.1.1.24] (222-152-170-159-fibre.sparkbb.co.nz. [222.152.170.159])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320d5bd9fd3sm27777096eec.4.2026.08.16.11.37.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Aug 2026 11:37:08 -0700 (PDT)
Subject: Re: [PATCH v2 2/5] fbdev: Give atafb proper parent
To: Helge Deller <deller@gmx.de>, linux-m68k@vger.kernel.org,
 geert@linux-m68k.org
References: <20260816073752.16656-1-schmitzmic@gmail.com>
 <20260816073752.16656-3-schmitzmic@gmail.com>
 <3d215ce1-6298-491e-81ef-b19bed7f1d9a@gmx.de>
Cc: Miro Kropacek <miro.kropacek@gmail.com>, linux-fbdev@vger.kernel.org
From: Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <41ca1d69-9a5e-7f4e-62a8-6f697e87e8f1@gmail.com>
Date: Mon, 17 Aug 2026 06:37:02 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <3d215ce1-6298-491e-81ef-b19bed7f1d9a@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Helge,

no changes to the fbdev patches - just didn't know how else to avoid 
issues with b4.

Cheers,

	Michael


Am 17.08.2026 um 02:38 schrieb Helge Deller:
> On 8/16/26 09:37, Michael Schmitz wrote:
>> From: Miro Kropacek <miro.kropacek@gmail.com>
>>
>> The atafb fb device registers no parent, causing a missing symlink
>> (/sys/class/graphics/fb0/device). Xorg fbdevhw driver looks for that
>> symlink when scanning for devices, so add a parent node for atafb.
>>
>> Signed-off-by: Miro Kropacek <miro.kropacek@gmail.com>
>> Reviewed-by: Michael Schmitz <schmitzmic@gmail.com>
>> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
>> Cc: <linux-fbdev@vger.kernel.org>
>> Link: https://lists.debian.org/debian-68k/2026/08/msg00000.html
>
> Did anything on the fbdev patches (#2-#4) changed between v1 and v2?
>
> Helge
>
