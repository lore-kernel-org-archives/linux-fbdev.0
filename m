Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC5C63D
	for <linux-fbdev@vger.kernel.org>; Fri, 13 Dec 2024 10:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734084941; cv=none; b=POvjLDq7BBgFIshPALNlzMXiCO1ZoL3yUn0NIHYWp6q0/C+aSdX8Y5Ywo3vH81YYyU+YnULZxv7xXKE+/K0hYphjuYy6I3TMrDcgOZ1dlMCN2bAMJ8TtNY1kiMCngQYEY0+q5dugR6Fg15M5vA+XbIoJPwt1lI+R373nn3IXWGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734084941; c=relaxed/simple;
	bh=qC2zro0kKmEsnpOYP2/rSLqAoj7cMOHkQpcqzVhMvrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kvPA51yMWSibMh/t86a5M9naYLuvIBHmwSyZBSpdSJtCnyeWN6yHM77O0tbuoPqtowDiauYHnLJ3B/1SlDzqJN8d1/PgjhYUjM25i1WUeii9hb04QZQmk/yZS8ORq1g6na/xFgoaNX5c2oroHingCgIbEuWkxYszKN5bSC9i7LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Y8lbF67nTz9svS;
	Fri, 13 Dec 2024 11:15:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6-COpe8Oi0vZ; Fri, 13 Dec 2024 11:15:37 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Y8lbB1Gh4z9svV;
	Fri, 13 Dec 2024 11:15:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 197918B773;
	Fri, 13 Dec 2024 11:15:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id YjGKXVr-q2aq; Fri, 13 Dec 2024 11:15:34 +0100 (CET)
Received: from [192.168.232.97] (unknown [192.168.232.97])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 96D688B763;
	Fri, 13 Dec 2024 11:15:33 +0100 (CET)
Message-ID: <941b3560-6572-476b-9e9f-c0a6df3e9ff4@csgroup.eu>
Date: Fri, 13 Dec 2024 11:15:33 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] fbdev: Fix recursive dependencies wrt
 BACKLIGHT_CLASS_DEVICE
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
 arnd@arndb.de, deller@gmx.de, simona@ffwll.ch, airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linuxppc-dev@lists.ozlabs.org
References: <20241212100636.45875-1-tzimmermann@suse.de>
 <20241212100636.45875-2-tzimmermann@suse.de>
 <8403f989-c1de-48c9-ab48-83c1abb9e6f2@csgroup.eu>
 <5484d576-d63e-4166-85ea-0b508b0cb865@suse.de>
 <1248a2b6-71b0-4909-917f-a5605415a816@csgroup.eu>
 <690acce6-3e57-4731-9949-f8bb06d9cb58@suse.de>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <690acce6-3e57-4731-9949-f8bb06d9cb58@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 13/12/2024 à 09:41, Thomas Zimmermann a écrit :
> Hi
> 
> 
> Am 13.12.24 um 09:33 schrieb Christophe Leroy:
>>
>>>
>>> The attached patch selects backlight support in the defconfigs that 
>>> also have PMAC_BACKLIGHT=y. Can you please apply it on top of the 
>>> patchset and report on the results?
>>>
>>
>> That works for the defconfig but it is still possible to change 
>> CONFIG_BACKLIGHT_CLASS_DEVICE manually.
>>
>> If it is necessary for PMAC_BACKLIGHT then it shouldn't be possible to 
>> deselect it.
> 
> Here's another patch that make it depend on BACKLIGHT_CLASS_DEVICE=y. 
> Can you please try this as well?

That looks good, no build failure anymore with BACKLIGHT_CLASS_DEVICE=m
