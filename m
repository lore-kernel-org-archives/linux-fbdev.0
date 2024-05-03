Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E1F139580
	for <linux-fbdev@vger.kernel.org>; Fri,  3 May 2024 05:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714713113; cv=none; b=IimmdZiExDqpg6Y+3yNG4vRG5Rs9Oc+X/Um/H+XPPKwGAnqWGuORYjCM/IXIwWKxPQxoVWE2s2mYIbAohZOKJh+8Zp9jIfnpDbetJsp1o4SYy5FEIn2Qa8DQrYC8PpJ1gMfwhWr2LAf4G/w8cQR0BmbKur9LxRVi2SbWh7jEAjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714713113; c=relaxed/simple;
	bh=4IFUujD0WtUytHMnCa5Oq26awC+SVnMB+m5+QMpSIrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1UMkEeW0sI7VNnjW8DmoVpYTK/HvrGoo6CYMcLchNiPc/ZVsnS9Cv5fE7mKDA7uZECde7MB8nlcT0oo8EhJvQ5rfVjGWadWEEt9Bow5EMtCWkZtLeFrmpcrZVc0YHVLyUWUR2QtFm+6hakVr/O1gsNSTh7cvuiXymIcRzwtvrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hckp1U3t; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hckp1U3t"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41adf155cffso60364715e9.2
        for <linux-fbdev@vger.kernel.org>; Thu, 02 May 2024 22:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714713110; x=1715317910; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IZ52txFEn84DZ4Gx318II2hjm45dLlkgVXuI6MMj02M=;
        b=hckp1U3tOXxRX0r+FHs4fCYqqOuurTULLqYOfu+oXH7ivDw4+Vas/tRrUev4BDbF/C
         R/hGkGJ0W7rmLNZu9NW5WuTO2l5LDnRDeGyeQNArOrJkG1HEK/ORUFxdrX3SpQDvzlb9
         vCP17nipEOu7jEo3NDRhRvTA2POyy830uj7ty43YqEU9MjwZc7E8gCbxYMaxir4ksYz/
         AIHezR0gb4aNX8iC6rE/U1KvvUcrLJimooaz9UXjTrYHGahwSxXP6vwI//QU+odLHZRY
         ++7Uoh6wan3+Q0LQYe8ACMK6j4W/yjBbvLnHAfeLuElTVWtyqM3mTurfLjsv6w01MAUm
         qKag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714713110; x=1715317910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZ52txFEn84DZ4Gx318II2hjm45dLlkgVXuI6MMj02M=;
        b=rpoAlozbtIK57eENx272FtR8nJaHKY96RhcX0wcjTQ4D/ZIMaHOA/vsungJUQBwV6j
         mPq0eb+GS77QlBnK3LUecoiShK4JOSlBADqfPJ/XTGeyYgmZjKMb+5TP3JAoNNSShQWV
         4pKURsoa906riW8+uMXFA1AXLm8V9F3k4BKkwKzv4B2QVsCCDqteuZa2Th327t5eaJp1
         dUT1YEL8yrp/Opm+mId932DujRbCKem5s5KnkHvMu9AWBnKOpSbR05NMZVnL8/Ef9E6k
         3gHNPi/FWd2QTLAyBo2YRU/fY54JVEEA7zS5F3sigmV04lijMRzLX4UnbMaIDb/P87cg
         dutw==
X-Forwarded-Encrypted: i=1; AJvYcCVERdKlp0mD/9YK7xUPfqCtS7WTLh3lqnH3VvRiu8xxczir/3uLCmaEojx3vnCcs3TuZ08kVYAyqcmY4K1e/8awfsplg2Pwk5KJBow=
X-Gm-Message-State: AOJu0Yz3YAk58nmo2IWUOARqThDlTwr2stx2VCprrlc5hcS22x5h7Maw
	7DX/hYKug9PY/OqDCgQAnGmPrilVBpaFIaYUNMNIUj8Etx9LZihDw9z/wFCbMnU=
X-Google-Smtp-Source: AGHT+IHlVU6WqV9hfbm78/kvRSpT3qBzDU+6UDBfCiHBW2deYrVDpU1cdv/gO3y+VfA5WQLnrHXNhQ==
X-Received: by 2002:a05:600c:3c93:b0:419:f2a0:138e with SMTP id bg19-20020a05600c3c9300b00419f2a0138emr1271927wmb.34.1714713110268;
        Thu, 02 May 2024 22:11:50 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id g19-20020a05600c311300b0041496734318sm7964771wmo.24.2024.05.02.22.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 22:11:50 -0700 (PDT)
Date: Fri, 3 May 2024 08:11:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ashok Kumar <ashokemailat@yahoo.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: fb_tinylcd Alignment to open parenthesis
Message-ID: <37db687e-ce7f-4f18-8464-f9b04226e14c@moroto.mountain>
References: <ZjRDUO6/M+RDCcQJ.ref@c>
 <ZjRDUO6/M+RDCcQJ@c>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjRDUO6/M+RDCcQJ@c>

On Thu, May 02, 2024 at 06:52:16PM -0700, Ashok Kumar wrote:
> Corrected coding style CHECK: Alignment should match open parenthesis
> 

The original author was aligned it deliberately to improve readability.

Just ignore checkpatch on this.

regards,
dan carpenter

