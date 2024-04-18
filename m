Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E21165FC6;
	Thu, 18 Apr 2024 14:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713449217; cv=none; b=iq/fLeaNmXuLAl1yb7iEdIgO0QRHmeGylagkq1rqPo7Msy9LzZTUNsWjqzOu3RxJNIYZAb2Bz+WY8ydeACWAfCATWiDYuLsDGlota0ND5IIqjo6sjT9l+o2CsjlBAyOEr6129dcG5VItJbzVZXgKp0rBEJuBYRiw1YaVLmTJ/1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713449217; c=relaxed/simple;
	bh=QqiNWfssQFTH36VfQob/swrV3uid20RygV7ZNOBu9v0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H1HLApi91n40iyzIL5r8rs/D+Zh6LC/4vwJ6BOgUtbEkSnk0F/dzKK+sXajA/EXdavhkXVD3eNcXtnSq9EO5gurKtwV+H+qfUNQg2l8ygSlTIFgfM2XZ5bkeEfi/VA3A/TQLWdcixKU6f1Ev2gvc/d9kef0fViPpdL0RnPijsXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2uWWcS5r; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ejosluox; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2uWWcS5r";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ejosluox"
Date: Thu, 18 Apr 2024 16:06:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713449214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Idxuchle8AcxxVwUDpWy041qfrtuUfRvGM0E/NVSF/I=;
	b=2uWWcS5rzBA9UwpilUAbugUDdytG6ZhJI7MgLJwTJ/0XfDwYcoNCLh6tjholyWZZNvAWz3
	EKmIqW2hV8HBA6AMsLEEPfHBfJUN9YhwVp1JQDFw5BdzxlllHEh/uPlgS3J1VmWDB77VmO
	R2I8nTGT2qJbPXlE/hBO+vIZyWyJkmjjCo1kfilpME2QmzbFxQ40lz8Upjr9OaycEMce9T
	XhCnWDRW/zZtYCzkpgd9rGfTZ9retKApw4WaJaJi6aooBNmSIjnXXPJnIsM16ulTT3r0oh
	v/hxwVFRJOciB/P5lvgoH05F3wRMlVT8LFZ5eSdOydQnvE4acsXVXFEQedrq2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713449214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Idxuchle8AcxxVwUDpWy041qfrtuUfRvGM0E/NVSF/I=;
	b=EjosluoxqQVNEdbKPkBK1vZISCD5HzUSPH/LPqd0lTe2vCFr85v9qrNJ45ddZJ/CDNZ7tQ
	Q2F9CN4lLBbnyhDQ==
From: Nam Cao <namcao@linutronix.de>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: jayalk@intworks.biz, Daniel Vetter <daniel@ffwll.ch>, deller@gmx.de,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 tiwai@suse.de, bigeasy@linutronix.de, patrik.r.jakobsson@gmail.com, LKML
 <linux-kernel@vger.kernel.org>, Vegard Nossum <vegard.nossum@oracle.com>,
 George Kennedy <george.kennedy@oracle.com>, Darren Kenny
 <darren.kenny@oracle.com>, chuansheng.liu@intel.com
Subject: Re: [bug-report] task info hung problem in fb_deferred_io_work()
Message-ID: <20240418160652.68df1a86@namcao>
In-Reply-To: <271372d6-e665-4e7f-b088-dee5f4ab341a@oracle.com>
References: <271372d6-e665-4e7f-b088-dee5f4ab341a@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 2024-04-18 Harshit Mogalapalli wrote:
> While fuzzing 5.15.y kernel with Syzkaller, we noticed a INFO: task hung 
> bug in fb_deferred_io_work()

Which framebuffer device are you using exactly? It is possible that
the problem is with the device driver, not core framebuffer.

Best regards,
Nam
