Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1731474B8
	for <linux-fbdev@vger.kernel.org>; Fri,  5 Jul 2024 10:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720175220; cv=none; b=dUK/Z4efgJo3J+tMxE9mpIgg+PV2wMEl/1Zclhh2sYTOyXOVb76/akAF6zBmljnXYqifqG1tQHJkrpMuZyXW0xOl0m9HIfvsw5BcbaGpzO/WYk/rDkHLTvDPyif3agA5Bu8fK40JvIxmWy9LI1J/tHkf4MDGumVUoAT8zUt4pXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720175220; c=relaxed/simple;
	bh=yGbo/J4eUFlKgy2mpmn6Hpr73tNFtSqMvohyWG45viU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dkqzNbugYy5+jXi9iPHpSM9EzKvSOopNlnMCQHZEfILCjDxe8QaZYuWBBFmNuXmrl1Lv+XLvCZweCgT8pkfr6qSM8qj+ri+RJeAbsfilHkriJfgOYE0wtKFmRTciICg1svhD7MGkQVRvgqThoSVyqSeCXxZUDhL84fVtHLBPL7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uUkf/C9/; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uUkf/C9/"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-445033fbc24so10794781cf.3
        for <linux-fbdev@vger.kernel.org>; Fri, 05 Jul 2024 03:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720175217; x=1720780017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yGbo/J4eUFlKgy2mpmn6Hpr73tNFtSqMvohyWG45viU=;
        b=uUkf/C9/RCS1HNEdopUdtpbZgZjAf/On16XiM4fSe3zHAtRryiPBJjXQwcvE17DiBJ
         EluE9uskGRL1YzjWKZW1e8UDJrbup2OmNZ+uTXIlPvHKAcN398CzJ4Wf/8Ora1QFiqco
         v++HU5FVBW6ch+nJ4YOOPTsQHmaYeYMlz/vLt0LIKmajnAMwH/SJsYyN5SI0RVB1szXG
         fr2xw67MACOTluwgVmQ7cv5/GDXvztAQR2v9LRVu4W3CbmjacVIki17ora1B6/D12E3L
         1RhjQ+MjoHWvp38fymZnsGL5YYx02GN3zIRiv4YntNW+ReomGdIEdI0JYeZcKBXNlfok
         k6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720175217; x=1720780017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGbo/J4eUFlKgy2mpmn6Hpr73tNFtSqMvohyWG45viU=;
        b=bCa1HtfmZ1Wf4z49/SEPG935sQ0bTt2BoFLBvaNOJv1EB9/2Fd69Y9gQOyPV0ZSvHn
         ebllspPmVnRX79+3+RuKXuFsfbmaSTfCj3SxbVsMVgLCIWVUzwf/qFVBZbvwBgQVbPwu
         Zg5yaFRhJg10fniulomUU4Wva1n9UujnQ/qzqM4qVgHo4rzGjApmvfEZY0yF2Rhx3iDa
         WnAO/UX3dyktC/Gf52eJ0AQEnzy1v17U/e9ACmWAGu8DcJ4W3wsHaPyPrQMVRdG1iQK5
         kLY0GBbC1BPJzK0GXFe18C7bq814mbHetStfEnYoNzUpetrAy/l4XGf0R2jp0NBHa7pQ
         nuqQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+dzL2r5hP6ufuB+eABAPMAy8tyWOH04Xa5PR0HuqUzf7JSB52eSIZdorWyqZBRLRsyRI5Wqfig38E2mipS78k3UO47jTOpIH96ug=
X-Gm-Message-State: AOJu0YwUjTu7b2/TP/JY0SeobVP/UXn0Rd1TBe32cSfBVtDioZ3QMvJQ
	40nXNnDoIP/z1c0KjRdawgLDS2DFayy7l5V9Ef+2LwLqHndU6WebQfcbE0PhiFk=
X-Google-Smtp-Source: AGHT+IHU8EOVpqYrcQTs3CHIcL+/+yQvLWdVExug/MFZEndiHTAoPACMoBY2RZmg3CFNlc85aj2geQ==
X-Received: by 2002:a05:6214:5013:b0:6b5:4b10:7849 with SMTP id 6a1803df08f44-6b5ecfb53f2mr47314046d6.1.1720175217387;
        Fri, 05 Jul 2024 03:26:57 -0700 (PDT)
Received: from aspen.lan ([185.80.132.160])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b5f47b8260sm6893286d6.100.2024.07.05.03.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 03:26:56 -0700 (PDT)
Date: Fri, 5 Jul 2024 11:26:53 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: lee@kernel.org, jingoohan1@gmail.com, deller@gmx.de,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] backlight: l4f00242t03: Add check for spi_setup
Message-ID: <20240705102653.GB110803@aspen.lan>
References: <20240705092800.3221159-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705092800.3221159-1-nichen@iscas.ac.cn>

On Fri, Jul 05, 2024 at 05:28:00PM +0800, Chen Ni wrote:
> Add check for the return value of spi_setup() and return the error
> if it fails in order to catch the error.
>
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
