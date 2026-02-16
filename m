Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BAA2E413
	for <linux-fbdev@vger.kernel.org>; Mon, 16 Feb 2026 00:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771201624; cv=none; b=BMc77McTHU5eLWTMHd8WYEgvn4EPw6aA6Tjf0+MO7oBcPOFVeaWYm+nppj3Bba2k/AbHQuvuL9nV2G2J3gs7gWO88/Kii5hydzjcwtMUBxU3vE3lx+HkyXubveJ+s8c7hZpqzSiFJziNmtDuCOSsWayPgGUFaayfizNsHzbAQt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771201624; c=relaxed/simple;
	bh=UNCOjVNEn3ftrD9xYGpuDxYt1FzsWi/wPyHJ7LrzDUk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=KcF5qgxxQ9Su7BnDkZu6XrzQPdTKf8PRVX9JwHKEntDVo3EQSeX8aYn14VNEvzLb8q8HdT6ohrvnRCeQOCCiN48SQivQDkChQd6XTi8Z3vb7WNkrcpv+OmrMY/d++B/r3XL0SkpL3oYrqlea9QWfRyuZhLmBY/D09KUIlBu3osY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GxjXGhwo; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxjXGhwo"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-79273a294edso22132747b3.3
        for <linux-fbdev@vger.kernel.org>; Sun, 15 Feb 2026 16:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771201622; x=1771806422; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNCOjVNEn3ftrD9xYGpuDxYt1FzsWi/wPyHJ7LrzDUk=;
        b=GxjXGhwoBy3zdjs+zFs9arx5SlFXkkHYi3opXjgz3bG+zEByekJO92m4AW7LM43VGx
         D7e9gf/JeuoVjWMoHyMuyt6sPyvQpw3L+ybid/qNUkc9KjQ2DMDS5oIAaH/UDq2tqgyw
         2/q59YRHGj1VdsSd6hZ7r3zhf+9a6lSNHAiP+le/S+eZVH5/VbmrmXu+SDOm8B7Iw75j
         Q3qZj2iVTD1ly4xWydawEscuRBAOsmQAhWhozM/tUo1q4BysRYPQJIIr+ndDykaeHtdC
         Yr6diYaxxrk8e/hfP9Nwan1p5ffwccABkgFZWdNI+05+dMRcCxkXDH8D80tUUiEo1Dpv
         +cnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771201622; x=1771806422;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UNCOjVNEn3ftrD9xYGpuDxYt1FzsWi/wPyHJ7LrzDUk=;
        b=H0MAJG1PwNnrjtaTwL8HZgUzHgD01lwevdztx3mkQq+WQTcyWiljIOZ0UOIuKqGe24
         gYEPREPtrULnai5i2RswovyqKfY4V9nFiqB+K23HiOdcamACkwfUDe7tPTWlxFsEJKVO
         1E6Eo0sRlFkll62jozfY3snXGt0OpcxMTCHmRFLsEL/p2dTHTp91m4QhDX5EKNOAT0cn
         cOM7F759hx6Wu3eXkDpHevj8BklGEt57Yk60m84Td2e5FzY2chSYl/ibQQet5KBZyLHI
         SEZrythJvXKFYCDVEr8j7Itah4Ffg7cMhwuVHrMC3CKgh7VjLBVo3hkvEuuV8FtGTeQ6
         cGQw==
X-Gm-Message-State: AOJu0YwCxKh3LFHcUA9ah8hv24uzZ/l6hvA2bbAcjSHjpJu4mcVOIV1j
	Y078gQaIxVlPbDsi/heFKanB/P43SkhI9FkSwAWhpXovVlFV6pfz8ev2
X-Gm-Gg: AZuq6aIgPkU2Jzx+9OVwGmJVX39VvhtoRQuAQyynJToln2bCMvK+dDtcwvmgvW+1Hbp
	KH3N6Pf3/ahNwbc0I3Rkq7U96y2h6A/dT4ZHytRJ+LWC4p1ebfx+VA08FL2drdUqdX4YHe8E1gf
	1RV/qSeLNP1zNc5C/5iA6GKyw9lqBGiQdFbD3JZdzkgl7RjIVzQuggvDBVhyM2uUyuYFaWC3baq
	rbN40iimFrt21HAGANCIf5Au82IMuydcEkwxFEyNTDwQk+L0QmsVEWdtvSNekSdjiRbpKkry3Uf
	ZBKgrOuNsWllOS3Y83izMOTu8AIciEAS1e0A0iYAFPcR+jEjRRVp84e/JXPAIUBLdvd3lULoVKv
	cT2AAoBQHHVRq5IPayfdGQBXqvNyvSW13H0PPjXwzum/EAv/brHawht4VSpq6ivVkbEFXWluRB5
	Ah6ce/Jv47dm6c4gSRN+519TI2fIrLMKlpkuFhpO290XLH7fgluUwnh25tNGxiEC6lo66TW4AKr
	pzX7Kd+s0BFcg1aklP7nTuOkJDaqSNw5++2tQBgzaQK6baZFu4=
X-Received: by 2002:a05:690c:d8c:b0:78f:f32e:8b5b with SMTP id 00721157ae682-797a0ab7623mr83950827b3.0.1771201622236;
        Sun, 15 Feb 2026 16:27:02 -0800 (PST)
Received: from localhost ([2601:7c0:c37c:4c00:e3a8:26f7:7e08:88e1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c177773sm94376507b3.2.2026.02.15.16.27.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Feb 2026 16:27:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 15 Feb 2026 18:26:46 -0600
Message-Id: <DGFYKGV9KCHJ.18PNMD6MZ52FR@gmail.com>
Cc: <linux-fbdev@vger.kernel.org>, <linux-staging@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: sm750fb: add missing const to g_fbmode array
From: "Ethan Tidmore" <ethantidmore06@gmail.com>
To: =?utf-8?q?Ey=C3=BCp_Kerem_Ba=C5=9F?= <baseyupkerem@gmail.com>,
 <sudipm.mukherjee@gmail.com>, <teddy.wang@siliconmotion.com>,
 <gregkh@linuxfoundation.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260215213102.111117-1-baseyupkerem@gmail.com>
In-Reply-To: <20260215213102.111117-1-baseyupkerem@gmail.com>

On Sun Feb 15, 2026 at 3:31 PM CST, Ey=C3=BCp Kerem Ba=C5=9F wrote:
> Checkpatch reported a warning that the static const char * array should p=
robably be static const char * const. This patch adds the missing const key=
word to g_fbmode array, moving it to read-only memory.

Please keep a maximum of 75 characters per line. Next time when
submitting a patch use "$ ./scripts/checkpatch.pl --strict <patch>" to
catch things like this.

Thanks,

ET

>
> Signed-off-by: Ey=C3=BCp Kerem Ba=C5=9F <baseyupkerem@gmail.com>
> ---
