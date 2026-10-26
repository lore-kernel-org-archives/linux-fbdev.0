Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793010564;
	b=FLbTh5uCutiDUwVOmpKU5XEbGk4Z8GQvMvLQ0VrUiGk0vMBXHbAHbyMkH1sZq0ygq9h/
	 3dcSOnSP3Xed6FvRxbU31Aey1rvfyKVmJj75TnvUa/Uy3d25AbpxYAqIgbPh9hg03J+F5
	 n6DZjrVvorMvDptPFYb5L025BX7fpRoMFXpu/kogQmlkWvc/uj66XXidREJ94Ygthok58
	 60XjPvcMerKrpJoxHLCEqieD5RvJAV0VcmsGwEG2+FkhHEhn8F7ELkkVW0ZxjxQVbVj9w
	 h+Wm1Hafjdxs9x7Ym5huYKZDDjZU9ktVs7wjX7G4EA1pmerHPtu7NADP4Vdd4Yoi42w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793010564;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=X80l1ktYVTyzYo/RbFVbsXtNEdr+d/QH53RjktV2YY8=;
	b=YA9Y6nffNI5wNZF1s48esmb9LxVr7XlP07FZ9dAqbCrda+VJKAPALlFb/iNHhRFFVIYJ
	 4CYOe4nyBcSrnj3oidY6qSH2JK+f0W8JKCMxDfKqcoSTLIcUfTr4i4sN7Y7ihA74jKtB6
	 Q/iv/WVOFp8AnT57TGoE4cakoxTo0kMEigPqNZnicCzPVTZ4qm5rmMjtj1NIkTgKfBqvv
	 Sa+ZsKkVPLCcCX6ejUVBrcz3ic4FpMCJOS3SNcmskb8/swZoqc4PnKTR86LL43xlvik/k
	 TsbcUxKzAnkfyPOnicr3t8xHkFtS1LCnAKkN63gp97AOhgkMoiqFo7BADx6xZsUILcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA86606A31D
	for <linux-fbdev@vger.kernel.org>; Mon, 26 Oct 2026 10:29:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CA86606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48df4f540ebso1352360f8f.3
        for <linux-fbdev@vger.kernel.org>; Mon, 26 Oct 2026 03:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793010557; x=1793615357; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X80l1ktYVTyzYo/RbFVbsXtNEdr+d/QH53RjktV2YY8=;
        b=m+LKHZDFEscz+sodHOusqm5YkfAmtoo4ISEaPlnWzdLVIL1X8WB6Jc+NFt8+5fKvzn
         ylkMs7azPwn8742b6eJ3BQwBirl3+AKUPG9Pf/dwh8zC9j12sgeBberI7qWLNkDTpawe
         JNSGK26YRqVT1m/dHf33BL8/ewzSeeczJxBhR6jCxDxMZcbxnim7ygu5Zi0s3tLBY2T/
         s/AmxZ23kW7QOPZACn51zW2rQb4udc7d6Fvuia2k7vmiS52v5c2atA6KWpQOLInF++Cd
         XHf7tRounlVBHuO1kAop7BW1ETWPnanb+3JsKrucbIQxsEaT7rsWky6mgeG3XDMmtZVt
         218A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793010557; x=1793615357;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X80l1ktYVTyzYo/RbFVbsXtNEdr+d/QH53RjktV2YY8=;
        b=QAwMjlFMpyIFR6uw3YuTxedNkn3nOHUZVUUKqa2JR7boXUMz1Qu+eKZxA3VqlDUuVl
         JHTmNaShM5afldOFY53n64Voz3nx8ovd1JMkB4Kgi6KLJACq5qLCh2cqlkgDeeg7N2Ws
         ybd7QveDmJ/P9jvvzNRZbZD9tmnQUKSsDal70IIRYXdTtFN5qBEovMmoDJ7CLz1uruWv
         KJl8zXS2ip3eBxNMpAhLtESf36EQC506h8/CKH/c7hEYEdfIEnUBAuS/kQ09JFkHU1Jw
         nJJF5n4M16Qk3zhCdJ6eBCK+Nz+7RtvhlaqLBM+mvFE+0l2uzMr5vxUjayRGrQTlBUTR
         Ojww==
X-Forwarded-Encrypted: i=1; AKwUvBylYo+sXltPoHpVhaw0S3gwezniS2Gub6MkDGXNF3zMTOxPw62dwV+59IifMjm2OUkq2nyDmpkgAkqSEQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIN8WvOQI5ygvl0WAMJsTFWUWTkRViais2gqNZ+MbNpU0IWqLnr
	EIxIQg1IaZgtSZxUPd8IpTZdsEhnvk2avnInYGT4f0DLWDBX9nne8Z1r
X-Gm-Gg: AYBFou1njmgjzN3ypi41t7s+w/Z2O6+YmcNruF+ZYTi4kCgGpoYRU+vHvP9l+OMVYvt
	YU1UxUevbv0t7lv8EtZs/+rS2sz9wNhI4vR+D+8JJfijrenPVdJsgWn1SRakSo/Dtdz+5HISJEO
	F65OA8y5lOn/pEhxCxAuK2ub93aWa5hPBXbRBZ79sqEF9XvJLx0gkukmHw19vWIeukvmcw2S6kV
	RFtNYFlOoyTwad3Y2IDRiVXVwSxxW2vtpOhUvRer9FoH/tKZyDZ8UJTNSz8JVfNwNlA4fych/h9
	3JKfqZ6LQsZcXXfUQ25XBQB0xcTB9TkbGbWN0ySsDXSlcqffkM4Kr0vSKkblhSbNvYZci4VHRcb
	Sx4LHRvWTo14tsOw/NeilNmZ6RSqrwluOHRXZs6yWBPqgogjzjQe0BvMkJdMZvu6AYt80HvOB4B
	o9sm/n59DyemHfIGzDmydK3ib0nlczWxzSAwg1TsSMb7JG+PeGwy40hE5/ObmxZ62LPawkvBQXj
	sSBCCjJD2Y2ooYUT17xlWNJ6g8N59tA3IuSXlebElgcnXD037xyiGX8YXAR2Cd0jSvVJT0q0A==
X-Received: by 2002:a05:6000:98f:b0:48b:db7:86a7 with SMTP id ffacd0b85a97d-48e3eba5d2fmr12088523f8f.50.1793010557470;
        Mon, 26 Oct 2026 03:29:17 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd48eesm15574100f8f.30.2026.10.26.03.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 03:29:16 -0700 (PDT)
Date: Mon, 26 Oct 2026 13:29:13 +0300
From: Dan Carpenter <error27@gmail.com>
To: himanshu bakshi <himanshu.bakshi478@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, dennylin0707@gmail.com,
	cenzhang@linux.microsoft.com, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: fbtft: remove unused fbtft_init_dbg()
Message-ID: <at8reTB8v7iU-IaT@stanley.mountain>
References: <20261026101815.73722-1-himanshu.bakshi478@gmail.com>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026101815.73722-1-himanshu.bakshi478@gmail.com>

Please always wait a day between resends...

regards,
dan carpenter

